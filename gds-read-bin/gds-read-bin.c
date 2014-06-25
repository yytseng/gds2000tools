/******************************************************************************
 * $Id: gds-read-bin.c,v 1.15 2008/06/22 21:00:10 tw Exp tw $
 * gds-read-bin - Read the response to an :ACQuire<X>:MEMory (GDS-2000 series),
 * 		  :ACQuire<X>:POINt (GDS-8x0), or :DISPlay:OUTPut? query.
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
 ******************************************************************************
 *
 * The filter does not send the necessary query. It just processes the
 * response data. The filter assumes its standard input is connected to
 * a tty device, with termios(3) capabilities. The filter temporary turns
 * of any special input processing of the device, to ensure typical tty
 * line discipline and special character processing don't alter the incoming
 * binary data (raw mode).
 *
 * The tty device's write (to the oscilloscope) direction is not altered,
 * so strictly speaking this in not a complete raw mode tty device
 * configuration.
 *
 */

#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>

#include "gds-read-bin.h"
#include "memory-list.h"
#include "snapshot-bmp.h"
#include "tty.h"
#include "error.h"

/**
 * Own binary name. Used in error messages
 */
char	*myName = NULL;		// argv[0]

/**
 * Format identifiers
 */
typedef enum {
	MEM,		// waveform (memory) data
	OUTP		// output (display screenshot) data
} FORMAT;

/*
 * Simple usage message
 */
void
usage() {
	die("usage: %s [-f <format>] [-c <cmap>] [-F <fieldsep>] [-0] [-h] [(-v <scale>) | (-V <25scale>)]",
									myName);
}


/*
 * Generic signal handler to restore tty state under "any"
 * circumstances
 * TODO: Consider moving to tty.c source file
 */
static void
sig_tty_restore(int signo)
{
	tty_restore();
	die("Data transfer interrupted");
}


/*
 * Handle alarm signal. SIGALRM is used to implement a simple
 * read timeout system.
 * TODO: Consider moving to read.c source file
 */
static void
sig_alarm(int signo)
{
	tty_restore();
	die("Not enough input data (timeout)");
}



/******************************************************************************
 * Main. Reads and converts the input data.
 *****************************************************************************/
int
main(int argc, char *argv[])
{
	int	opt;
	bool	hscale_flag;
	bool	vscale_flag;
	bool	header_flag;
	double	vscale= 1.;
	char	*endptr;
	char	*fieldsep;

	FORMAT	type = MEM;		// expected data type / format
	CMAP	cmap = STANDARD;

	//
	// Check command line options
	//
	myName = argv[0];
	hscale_flag = false;
	vscale_flag = false;
	header_flag = true;
	fieldsep    = " ";

	opterr = 0;
	while ((opt = getopt(argc, argv, "0c:f:hv:V:F:"))  != -1) {
		switch(opt) {
		case '0':	// don't write the header data out
			 header_flag = false;
			 break;
		case 'c':
			if(!strcmp(optarg, "standard")) {
				cmap = STANDARD;
			} else if(!strcmp(optarg, "improved")) {
				cmap = IMPROVED;
			} else if(!strcmp(optarg, "inksave")) {
				cmap = INKSAVE;
			} else {
				usage();
			}
			break;
		case 'f':	// expected format
			if(!strcmp(optarg, "mem")) {
				type = MEM;
			} else if(!strcmp(optarg, "outp")) {
				type = OUTP;
			} else {
				usage();
			}
			break;
		case 'h':	// scale horizontally
			 hscale_flag = true;
			 break;
		case 'v':	// scale vertically
		case 'V':
			vscale_flag = true;
			vscale = strtod(optarg, &endptr) /
						(opt == 'V' ? 25. : 1.);
			if(endptr == optarg || *endptr != '\0') {
				usage();
			}
			break;
		case 'F':	// output field separator
			fieldsep = optarg;
			break;
		default:
			usage();
			break;
		}
	}
	if(optind != argc) {
		 usage();
	}


	//
	// Set up signal handlers for the usual suspects and
	// for handling the read timeout (SIGALRM)
	// 
	if (signal(SIGTERM, sig_tty_restore) == SIG_ERR)
		die("signal(SIGTERM) setup error");
	if (signal(SIGINT, sig_tty_restore) == SIG_ERR)
		die("signal(SIGINT) setup error");
	if (signal(SIGQUIT, sig_tty_restore) == SIG_ERR)
		die("signal(SIGQUIT) setup error");
	if (signal(SIGALRM, sig_alarm) == SIG_ERR)
		die("signal(SIGALRM) setup error");

	//
	// Set input to raw mode
	//
	if (tty_raw_in() < 0) {
		die("serial interface input configuration error");
	}

	//
	// Read and print the data
	//
	switch(type) {
	case MEM:
		waveform(header_flag, hscale_flag, vscale_flag, vscale, fieldsep);
		break;
	case OUTP:
		snapshot(1, cmap);
		break;
	default:
		// should never happen ...
		die("Unsupported conversion requested.");
		break;
	}
	

	//
	// Reset device
	//
	if(tty_restore() < 0) {
		die("could not restore original input tty state");
	}

	return 0;
}

