#ifndef SNAPSHOT_BMP_H
#define SNAPSHOT_BMP_H
/******************************************************************************
 * $Id: snapshot-bmp.h,v 1.2 2008/06/21 22:13:03 tw Exp $
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

#include <stdbool.h>

/**
 * Format identifiers
 */
typedef enum {
	STANDARD,	// use standard colormap
	IMPROVED,	// "improved" colormap
	INKSAVE,	// inksave colormap
} CMAP;

/**
 * Read a screen snapshot (:DISPlay:OUTPut? query response) from the
 * oscilloscope. Write the result as a BMP image file.
 */
void snapshot(int fd, CMAP cmap_id);

#endif
