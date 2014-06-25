/******************************************************************************
 * $Id: memory-list.c,v 1.3 2008/06/22 21:00:10 tw Exp tw $
 * memory-list - Read the response to an :ACQuire<X>:MEMory (GDS-2000 series)
 * 		  or :ACQuire<X>:POINt (GDS-8x0) command 
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

#include <stdint.h>	// C99
#include <stdbool.h>	// C99
#include <stdio.h>

#include "gds-read-bin.h"
#include "read.h"
#include "tty.h"
#include "error.h"

/*
 * Get endian definition. On some systems other byte order macros are
 * available via
 * #include <sys/types.h>
 * #include <sys/param.h>
 */
#ifdef __sparc
#     include <sys/isa_defs.h>
#else
#     include <endian.h>
#endif


/*
 * Union to convert four received bytes to a floating point value.
 * Needed for decoding the sampling interval size.
 * NOTE: Assumes platform uses IEEE 754 fp format, as this happens to be the
 * 	 (undocumented) format used by the GDS-2000.
 */
typedef union 
{
	uint8_t a[4];	// received bytes	
	float 	f;	// desired result value	
} Interval;


/*
 * Read and convert the waveform data.
 */
void
waveform(
	bool header_flag,
	bool hscale_flag,
	bool vscale_flag,
	double vscale,
	char *fieldsep)
{
	int	c;		// input byte
	int	i;		// loop counter
	int	size;		// size of data
	int16_t	data;		// one datum
	Interval iv;		// measurement interval


	size = read_header();
	//
	// TODO: Check for known sizes isntead?
	// 
	if(size < 10 || size > 50008 || size % 2) {
		die("Implausible data size %d\n", size);
	}

	//
	// Get time interval (an IEEE float number, binary)
	//
#if __FLOAT_WORD_ORDER == __LITTLE_ENDIAN
	for(i = 3; i >= 0; i--) {
#else
	for(i = 0; i < 4; i++) {
#endif
		iv.a[i] = next();
	}
	// }

	if(header_flag) printf("Interval%s%g\n", fieldsep, iv.f);

	//
	// Get channel indicator (8 bit binary value)
	//
	c = next();
	if(c < 1 || c > 4) {
		die("Implausible channel number %d", c);
	}
	if(header_flag) printf("Channel%s%d\n", fieldsep, c);

	//
	// Three reserved bytes. Undefined meaning. Skip.
	//
	for(i = 0; i < 3; i++) {
		next();
	}

	//
	// Adjust size value and take 2 bytes per value into account
	//
	size -= 8;	// size of previous interval + channel id + reserved
	size /= 2;	// 2 bytes per value
	if(header_flag) printf("Length%s%d\n", fieldsep, size);

	//
	// Get all data
	//
	for(i = 0; i < size; i++) {
#if __BYTE_ORDER == __LITTLE_ENDIAN
		data = next() << 8;	
		data |= next();
#else
		data = next();
		data |= next() << 8;
#endif
		if(hscale_flag) {
			if(vscale_flag) {
				printf("%g%s%g\n", i * iv.f, fieldsep,
								data * vscale);
			} else {
				printf("%g%s%d\n", i * iv.f, fieldsep, data);
			}
		} else if(vscale_flag) {
			 printf("%d%s%g\n", i, fieldsep, data * vscale);
		} else {
			printf("%d%s%d\n", i, fieldsep, data);
		}
	}
}
