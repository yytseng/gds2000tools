#ifndef READ_H
#define READ_H

/******************************************************************************
 * $Id: read.h,v 1.1 2008/06/15 14:18:14 tw Exp $
 * read - Basic data read functions
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

#include <stdint.h>	// C99 header file 

#define READ_TIMEOUT	(2)	// max. time in seconds to wait for an
				// input character

/*
 * Get the next byte under timeout supervision.
 */
uint8_t next(void);

/**
 * Read and evaluate the data header.
 */
int read_header(void);

#endif
