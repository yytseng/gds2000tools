/******************************************************************************
 * $Id: read.c,v 1.1 2008/06/15 14:18:14 tw Exp $
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

#include <unistd.h>
#include <signal.h>
#include <stdio.h>

#include "read.h"
#include "error.h"

/*
 * Get the next byte under timeout supervision.
 */
uint8_t
next(void) {
	uint8_t c;
	int r;

	alarm(READ_TIMEOUT);
	r = read(STDIN_FILENO, &c, 1);
	alarm(0);

	if(r != 1) {
		die("Not enough data");
	}
	return c;
}


/**
 * Read and evaluate the data header.
 */
int
read_header() {
	int	c;		// input byte
	int	i;		// loop counter
	int	size;		// size of data
	int 	size_size;	// size of size field in input

	//
	// Check for "magic" character: #
	//
	if((c = next()) != '#') {
		 die("Format error. Expected '#', got %x", c);
	}

	//
	// Get length of length field (an ASCII digit)
	//
	c = next();
	if(c < '0' || c > '9') {
		 die("Format error. Expected length '0' ... '9', got %c", c);
	}
	size_size = c - '0';

	//
	// Get data length (an ASCII number)
	//
	size = 0;
	for(i = 0; i < size_size; i++) {
		c = next();
		if(c < '0' || c > '9') {
			 die("Format error. Expected digit '0' ... '9', got %c", c);
		}
		size = (size * 10) + c - '0';
	}
	
	
	return size;
}
