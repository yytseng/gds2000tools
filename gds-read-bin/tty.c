/******************************************************************************
 * $Id: tty.c,v 1.1 2008/06/15 14:18:14 tw Exp $
 * tty - tty configuration
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

#include <termios.h>
#include <unistd.h>

#include <stdbool.h>

#include "tty.h"

static struct termios	orig_term_conf;// tty config as found at prg start 
static bool		ttysaved = false;

/*
 * Restore tty configuration to original settings.
 */
int
tty_restore()
{
	if (!ttysaved)
		return 0; 

	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_term_conf) < 0) {
		return -1;
	}
	ttysaved = false;
	return 0;
}


/*
 * Configures serial interface, (including CDC-ACM USB serial emulation).
 * Interface input (to computer) needs to be put into
 * non-canonical / raw mode. Output to oscilloscope will be left as-is.
 */
int
tty_raw_in()
{
	struct termios	new_term_conf;

	if(!isatty(STDIN_FILENO))
		return 0;	// not a tty

	if (tcgetattr(STDIN_FILENO, &orig_term_conf) < 0)
		return -1;
	ttysaved = true;

	new_term_conf = orig_term_conf;

	//
	// Turn off the usual line processing suspects that can mess
	// with the input data
	//
	// * echo off
	// * echo newline off
	// * canonical mode off
	// * extended input processing off
	// * signal chars off
	//
	new_term_conf.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);

	//
	// Turn off input processing
	//
	// * convert break to null byte
	// * no CR to NL translation
	// * no NL to CR translation
	// * don't mark parity errors or breaks
	// * no input parity check
	// * don't strip 8th bit off
	// * no XON/XOFF software flow control
	//
	new_term_conf.c_iflag &= ~(IGNBRK | BRKINT | ICRNL |
					INLCR | PARMRK | INPCK | ISTRIP | IXON);

	//
	// Turn off character processing
	//
	// * clear current char size mask
	// * no parity checking
	// * force 8 bit input
	//
	new_term_conf.c_cflag &= ~(CSIZE | PARENB);
	new_term_conf.c_cflag |= CS8;

	//
	// Block until at least one byte received. Don't use timeout on
	// this level, since this requires the reception of at least one
	// character to start the timer (inter character timer).
	// Timeout will be handled via alarm() later.
	//
	new_term_conf.c_cc[VMIN]  = 1;
	new_term_conf.c_cc[VTIME] = 0;

	if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &new_term_conf) < 0)
		return -1;
	return 0;
}
