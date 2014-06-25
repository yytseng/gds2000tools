#ifndef MEMORY_LIST_H
#define MEMORY_LIST_H
/******************************************************************************
 * $Id: memory-list.h,v 1.2 2008/06/21 22:13:03 tw Exp $
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

#include <stdbool.h>

/*
 * Read and convert the waveform data
 */
int waveform(
	bool header_flag,
	bool hscale_flag,
	bool vscale_flag,
	double vscale,
	char *fieldsep);

#endif
