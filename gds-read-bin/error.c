/******************************************************************************
 * $Id: error.c,v 1.2 2008/06/22 21:00:10 tw Exp tw $
 * error - Simple error handling functions for gds-read-bin
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

#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "gds-read-bin.h"
#include "tty.h"


/*
 * Exit program with a formated error message.
 */
void
die(const char *fmt, ...)
{
	va_list	ap;

	va_start(ap, fmt);

	tty_restore();
	fflush(stdout);
	fputs(myName, stderr);
	fputs(": ", stderr);
	vfprintf(stderr, fmt, ap);
	fputc( '\n', stderr);
	fflush(NULL);	// flushes all stdio output streams 

	va_end(ap);
	exit(1);
}
