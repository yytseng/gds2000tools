/******************************************************************************
 * $Id: snapshot-bmp.c,v 1.7 2008/06/22 21:00:10 tw Exp tw $
 * snapshot-bmp.c	- read screen snapshot data, write as bmp image
 *
 * Copyright (C) 2008 Thomas Weidenfeller
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *****************************************************************************/

#include <errno.h>
#include <stdio.h>
#include <stdbool.h>	// C99 header file 
#include <unistd.h>

#include "snapshot-bmp.h"
#include "read.h"
#include "error.h"

/**
 * The save-to-usb oscilloscope function stores BMPs, so
 * gds-read-bin does this, too. Not that BMP is a great format,
 * but who cares.
 *
 * The created BMP differs in multiple internal aspects from
 * the ones created by the save-to-usb function. That shouldn't
 * matter in practice.
 */

/*
 * Image data and image format basics.
 *
 * The image data plane is always received, whether :DISPlay:OUTPut 0 or 
 * :DISPlay:OUTPut 1 is set.
 * There are a number of unused lines in the received image data, as the
 * oscilloscope only uses 234 lines but has an internal image memory of
 * 256 lines. As there is no information in the additional rows they
 * will be skipped.
 */
#define IMG_WIDTH		(320)		// visible columns
#define IMG_HEIGHT		(234)		// visible rows
#define IMG_DEAD_ROWS		(256 - IMG_HEIGHT)	// unused lines

#define IMG_BPP			(4)		// four bits make up one pixel
#define IMG_PPS			(8 / IMG_BPP)	// pack two pixels in a byte
#define IMG_COLORS		(1 << IMG_BPP)

/*
 * Overlay planes format.
 *
 * Thanks to GW Instek for providing some hints about the encoding.
 *
 * When :DISPlay:OUTPut 1 is set, two additional planes are added to
 * the basic image data. Each plane consists of 204 x 304 2bpp pixels,
 * four pixels packed in a byte. The packed pixels are vertically
 * (y direction) packed, and not as one would expect horizontally oriented.
 * A byte contains pixel information for (x, y), (x, y+1), .., (x, y + 3).
 *
 * Each overlay plane has an offset from the normal image's origin and is
 * therefore smaller than the image.
 *
 * The colors are encoded as it follows:
 * 
 * Plane 1 (graticule):
 * 	0: transparent
 * 	1: color index 0x0E (red) into color map
 * 	2: color index 0x08 (dark gray) into color map
 * 	3: color index 0x04 (cyan) into color map [GW Instek support says
 * 	   0x0E, too, but that doesn't work, as this would be red] 
 *  
 * Plane 2 (trigger marks):
 * 	0: transparent
 * 	1: color index 0x02 (yellow) into color map
 * 	2: color index 0x07 (white) into color map
 * 	3: color index 0x06 (light green) into color map
 */
#define PLANE_WIDTH		(304)
#define PLANE_HEIGHT		(204)
#define PLANE_XOFF		(6)		// horizontal offset from image
#define PLANE_YOFF		(22)		// vertical offset from image
#define PLANE_BPP		(2)		// bits per pixel
#define PLANE_PPS		(8 / PLANE_BPP)	// pixel per sample (byte)
#define PLANE_PLANES		(2)		// two additional planes
#define PLANE_COLORS		(1 << PLANE_BPP)// possible colors per plane
#define PLANE_SINGLE_SIZE	(PLANE_WIDTH * PLANE_HEIGHT / PLANE_PPS)
#define PLANE_TOTAL_SIZE	(PLANE_SINGLE_SIZE * PLANE_PLANES)

#define PLANE_TO_IMG_X(x)	((x) + PLANE_XOFF)
#define PLANE_TO_IMG_Y(y)	((y) + PLANE_YOFF)
#define PLANE_TO_IMG_NDX(x, y)	(PLANE_TO_IMG_X(x) + PLANE_TO_IMG_Y(y) * IMG_WIDTH) / IMG_PPS;


/*
 * Input and output file sizes
 */
#define RAW_BYTES_IN		(IMG_WIDTH * (IMG_HEIGHT + IMG_DEAD_ROWS))
#define RAW_BYTES_OUT		(IMG_WIDTH * IMG_HEIGHT / IMG_PPS)
#define RAW_BYTES_LONG_IN	(RAW_BYTES_IN + PLANE_TOTAL_SIZE)

/*
 * BMP image format specification
 */
#define BASIC_HEADER_SIZE	(14)	// standard BMP, fixed size
#define INFO_HEADER_SIZE	(40)	// standard BMP Windows v3 info header
#define COLOR_PALETTE_SIZE	(IMG_COLORS * 4) // four components BGRA 
#define DATA_OFFSET		(BASIC_HEADER_SIZE + INFO_HEADER_SIZE	\
				    + COLOR_PALETTE_SIZE) // start of data
#define TOTAL_SIZE		(RAW_BYTES_OUT + DATA_OFFSET)

// Store first 16 bits as two bytes, LSB first
#define VAL16(i)	(i) & 0xFF,		\
			((i) >> 8) & 0xFF

// Store first 32 bits as four bytes, LSB first
#define VAL32(i)	VAL16(i),		\
			((i) >> 16) & 0xFF,	\
			((i) >> 24) & 0xFF

/**
 * A fixed BMP image header, sans the colormap
 */
static uint8_t basic_header[] = {
	'B', 'M',			// Magic number
	VAL32(TOTAL_SIZE),		// File size
	VAL32(0),			// reserved
	VAL32(DATA_OFFSET),		// Offset to bitmap data
	VAL32(INFO_HEADER_SIZE),	// Info-Header Id and size
	VAL32(IMG_WIDTH),		// Image width
	VAL32(IMG_HEIGHT),		// Image height
	VAL16(1),			// One colorplane
	VAL16(IMG_BPP),			// Bits/pixel
	VAL32(0),			// No compression
	VAL32(RAW_BYTES_OUT),		// Raw image size
	VAL32((96 * 10000) / 254 + 1),	// Horizontal resolution 96dpi
	VAL32((96 * 10000) / 254 + 1),	// Vertical resolution 96dpi
	VAL32(IMG_COLORS),		// Colors in color palette
	VAL32(IMG_COLORS),		// All colors are "important"
};


/**
 * Colormap trying to represent the snapshot with the screen
 * colors of the oscilloscope. However, the map might
 * deviate for some colors.
 */
static uint8_t cmap_standard[] = {
	//B    G     R     A Component
	0x00, 0x00, 0x00, 0x00, //  0 Main background, black
	0x00, 0x00, 0x00, 0x00, //  1 Menu foreground, black
	0x00, 0xff, 0xff, 0x00, //  2 CH1, date/time, yellow
	0xc5, 0x00, 0xff, 0x00, //  3 CH3 red
	0xff, 0xff, 0x00, 0x00, //  4 CH2, trigger freq., cyan
	0x66, 0xff, 0x66, 0x00, //  5 CH4 green
	0x66, 0xff, 0x66, 0x00, //  6 Trig'd, h/div, light green
	0xff, 0xff, 0xff, 0x00, //  7 USB/RS232, average, Main label, white
	0x88, 0x88, 0x88, 0x00, //  8 Graticule, dark grey
	0x22, 0x22, 0x88, 0x00, //  9 ?
	0x55, 0x00, 0x00, 0x00, // 10 Outer frame, blue
	0xbb, 0xbb, 0xbb, 0x00, // 11 Menu background, grey
	0x33, 0x66, 0x99, 0x00, // 12 ?
	0x88, 0x88, 0x88, 0x00, // 13 ?
	0x22, 0x22, 0xff, 0x00, // 14 reverse background red
	0xff, 0xff, 0xff, 0x00, // 15 ?
};

/**
 * "Improved" Colormap.
 */
static uint8_t
cmap_improved[] = {
	//B    G     R     A Component
	0x60, 0x60, 0x60, 0x00, //  0 Main background, original 000000 black
	0x00, 0x00, 0x00, 0x00, //  1 Menu foreground, original 000000 black
	0x00, 0xff, 0xff, 0x00, //  2 CH1, date/time original FFFF00, yellow
	0x80, 0x00, 0xff, 0x00, //  3 CH3, original FF00C5, red
	0xff, 0xff, 0x00, 0x00, //  4 CH2, trigger freq., original 00ffff blue
	0x30, 0xff, 0x40, 0x00, //  5 CH4, original 66ff66 green
	0x40, 0xff, 0x66, 0x00, //  6 Trig'd, h/div, original 66ff66
	0xff, 0xff, 0xff, 0x00, //  7 USB/RS232, average, Main label,
				//    original FFFFFF white
	0x88, 0x88, 0x88, 0x00, //  8 Graticule?, original 888888
	0x22, 0x22, 0x88, 0x00, //  9 ?, original 882222
	0x99, 0x8a, 0x7a, 0x00, // 10 outer "blue" frame, original 000055
	0xe0, 0xe0, 0xe0, 0x00, // 11 menu background, original BBBBBB
	0x33, 0x66, 0x99, 0x00, // 12
	0x88, 0x88, 0x88, 0x00, // 13
	0x22, 0x22, 0xff, 0x00, // 14 reverse background, original FF2222
	0xff, 0xff, 0xff, 0x00, // 15
};


/**
 * Colormap trying to represent the snapshot in "inksave" colors,
 * similar to the inksave option of the oscilloscope.
 * However, the map might deviate for some colors.
 */
static uint8_t
cmap_colorsave[] = {
	//B    G     R     A Component
	0xFF, 0xFF, 0xFF, 0x00, //  0
	0x00, 0x00, 0x00, 0x00, //  1
	0x00, 0xB0, 0xFF, 0x00, //  2
	0xC5, 0x00, 0xFF, 0x00, //  3
	0xFF, 0xFF, 0x00, 0x00, //  4
	0x66, 0xFF, 0x66, 0x00, //  5
	0x66, 0xFF, 0x66, 0x00, //  6
	0x00, 0x00, 0x00, 0x00, //  7
	0x88, 0x88, 0x88, 0x00, //  8
	0x22, 0x22, 0x88, 0x00, //  9
	0xff, 0xff, 0xff, 0x00, // 10
	0xdd, 0xdd, 0xdd, 0x00, // 11
	0xdd, 0xdd, 0xdd, 0x00, // 12
	0x88, 0x88, 0x88, 0x00, // 13
	0x22, 0x22, 0xff, 0x00, // 14
	0x00, 0x00, 0x00, 0x00, // 15
};

/**
 * All colormaps. To be indexed by cmap_id.
 */
static uint8_t
*cmaps[] = { cmap_standard, cmap_improved, cmap_colorsave };
 

/**
 * Mapping of colormap indices in overlay plane 1 to image colormap
 * indices.
 */
static uint8_t
cindex_p1[] = { 0xFF /* not used */, 0x0E, 0x08, 0x04 };

/**
 * Mapping of colormap indices in overlay plane 2 to image colormap
 * indices.
 */
static uint8_t
cindex_p2[] = { 0xFF /* not used */, 0x02, 0x07, 0x06 };


//////////////////////////////////////////////////////////////////////////////
// Functions

/**
 * Write a byte array.
 */
static void
bin_write(int fd, const uint8_t *data, size_t size) {
	int n;
	int off = 0;

	while((n = write(fd, (void *)data + off, size)) != size) {
		if(n < 0) {
			if(errno != EINTR) {
				die("Image write failed.");
			}
			n = 0;
		}
		size -= n;
		off += n;
	}
}

/**
 * Decode one overlay plane and merge it into the current
 * image data.
 * See beginning of this file for an overly plane format
 * description.
 */
static void
read_overlay(uint8_t *data, uint8_t *cindex) {

	int ybyte;		// vertical input byte counter
	int yoff;		// vertical coordinate offset
	int x;			// horizontal plane coordinate
	uint8_t psample;	// one plane sample from the input
	uint8_t pcolor;		// single color index extracted from psample
	uint8_t *ipos;		// position in image data
	uint8_t isample;	// image sample to be partly overwritten

	for(ybyte = 0; ybyte < (PLANE_HEIGHT / PLANE_PPS); ybyte++) {
		for(x = PLANE_WIDTH - 1; x  >= 0; x--) {
			psample = next();
			for(yoff = 0; yoff < PLANE_PPS; yoff++) {
				pcolor = psample & 0x03;
				psample >>= PLANE_BPP;
				if(!pcolor) continue;	// transparent

				// Corresponding image index and image sample
				ipos = data + PLANE_TO_IMG_NDX(x,  ybyte * PLANE_PPS + yoff);
				isample = *ipos;
				
				// Override image nibble data with overlay plane data
				*ipos = x & 0x01
					? (isample & 0xF0) | cindex[pcolor]
					: (isample & 0x0F) | cindex[pcolor] << 4
					;
			} // yoff
		} // x
	} //ybytes
}

/**
 * Read a screen snapshot (:DISPlay:OUTPut? query response) from the
 * oscilloscope. Writes the result in as BMP image file.
 * Handles both :DISPlay:OUTPut 0 and :DISPlay:OUTPut 1 formats.
 */
static void
read_snapshot(uint8_t *data) {
	int x_half;
	int y;
	int size;

	size = read_header();
	if(size != RAW_BYTES_IN && size != RAW_BYTES_LONG_IN) {
		die("Wrong or unsupported image size. Got %d, wanted %d or %d.",
					size, RAW_BYTES_IN, RAW_BYTES_LONG_IN);
	}

	//
	// Get the image data from the oscilloscope and sort them into the
	// correct location in the bitmap. Pack two pixels in one byte.
	// Skip dead rows.
	//
	// The data comes in upside-down and right-to-left. And columns
	// before rows. So every aspect of this image data is unusual.
	// The data needs to be flipped horizontally, vertically and columns
	// to be filled in first instead of scanlines.
	//
	for(x_half = (IMG_WIDTH / IMG_PPS) - 1; x_half >= 0; x_half--) {
		for(y = IMG_HEIGHT - 1 ; y >= 0; y--) {
	                data[x_half + y * IMG_WIDTH / IMG_PPS] = next() & 0x0F;
		}
		for(y = 0; y < IMG_DEAD_ROWS; y++) {
			next();
		}
		for(y = IMG_HEIGHT - 1 ; y >= 0; y--) {
	                data[x_half + y * IMG_WIDTH / IMG_PPS] |= (next() << 4);
		}
		for(y = 0; y < IMG_DEAD_ROWS; y++) {
			next();
		}
	}
	if(size == RAW_BYTES_LONG_IN) {
		//
		// Read both overlay planes
		//
		read_overlay(data, cindex_p1);	// graticule
		read_overlay(data, cindex_p2);	// trigger marker
	}
}


/**
 * Write the result in a BMP image file.
 */
static void
write_snapshot(int fd, uint8_t *data, CMAP cmap_id) {

	//
	// Write fixed part of BMP header
	//
	bin_write(fd, basic_header, sizeof(basic_header));
	
	//
	// Write BMP color palette
	//
	bin_write(fd, cmaps[cmap_id], COLOR_PALETTE_SIZE);
	
	//
	// Finally write the image data
	//
	bin_write(fd, data, RAW_BYTES_OUT);
}

/**
 * Read a screen snapshot (:DISPlay:OUTPut? query response) from the
 * oscilloscope. Writes the result in a BMP image file.
 * Handles both :DISPlay:OUTPut 0 and :DISPlay:OUTPut 1 formats.
 */
void
snapshot(int fd, CMAP cmap_id) {
	uint8_t data[RAW_BYTES_OUT];	// Output data buffer

	read_snapshot(data);
	write_snapshot(fd, data, cmap_id);
}

