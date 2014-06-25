#ifndef TTY_H
#define TTY_H
/******************************************************************************
 * $Id: tty.h,v 1.1 2008/06/15 14:18:14 tw Exp $
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

/*
 * Restore tty configuration to original settings.
 */
int tty_restore();


/*
 * Configures serial interface, (including CDC-ACM USB serial emulation).
 * Interface input (to computer) needs to be put into
 * non-canonical / raw mode. Output to oscilloscope will be left as-is.
 */
int tty_raw_in();

#endif
