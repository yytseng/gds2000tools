#!/bin/bash
###############################################################################
# $Id: gdsh.functions.sh,v 1.19 2008/06/22 21:00:10 tw Exp tw $
# 
# Shell functions for gdsh
#
# Copyright (C) 2008 Thomas Weidenfeller
# 
# This file is part of gds2000tools/gdsh.
# 
# gds2000tools/gdsh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
# 
# gds2000tools/gdsh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with gds2000tools/gdsh.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################


#
# TODO: use alarm to create timeout if echo during sending hangs?
#

[ "0$GDSH_DEBUG" -gt 0 ] && echo "Loading lib/gdsh.functions" >&2

###############################################################################
# Low level functions
###############################################################################

#
# .TP
# \fBgds-open\fP [\fB-h\fP] [([\fB-u\fP] \fIusb-device\fP) | ([\fB-s\fP] \fIrs232-device\fP [\fIbaud\fP] [\fIparity\fP] [\fIstopbits\fP])]
# Opens the device for operation.
# The device name can be omitted if the environment variable
# .B GDSH_DEV
# is set to the preferred device.
# .IR baud ", " 
# .IR parity ", and" 
# .I stopbits
# are ignored if the device name looks like a USB COM-ACM device
# .RB ( ACM ,
# .BR USB ,
# or
# .B ttyU
# in the device name) or if the
# .B -u
# option is provided.
# .IP
# The default values for RS232 devices are 19200, N, 1. Possible values for
# .I parity
# are
# .BR n ,
# .BR N ,
# .BR e ,
# .BR E ,
# .BR o ,
# .B O
# for none, even and odd respectively. Possible values for
# .I stopbits
# are
# .BR 1,
# and
# .BR 2.
# .IP
# Possible options are
# .RS
# .TP
# .B -u
# Short help text.
# .TP
# .B -u
# Force to use USB communication default parameter.
# .TP
# .B -s
# Force to use RS232 communication default parameter for those
# not provided on the command line.
# .RE
# .IP
# The environment variable
# .B $GDSH_DEV_TYPE
# can be set to either
# .BR s ,
# .BR u ,
# or
# .BR ? ,
# corresponding to the 
# .BR -s ,
# or
# .B -u 
# command line option, or to no command line option.
# .\"

function _gds-open-usage () {
	cat >&2 <<!
usage gds-open [-h] [[-u] <usb-device>]
      gds-open [-h] [[-s] <rs232-device> [<baud>] [<parity>] [<stopbits>]]
-h This help text
-u Force to use USB communication defaults
-s Force to use RS232 communication defaults if non provided on the
   command line.
!
}

gds-open () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-open $@" >&2
	local type="${GDSH_DEV_TYPE:-?}"
	local o
	OPTIND=1
	while getopts "hsu" o
	do
		case "$o" in
		h)	_gds-open-usage 2>&1
			return 0
			;;
		s)	type="s"	# force serial defaults
			;;
		u)	type="u"	# force USB defaults
			;;
		*)
			_gds-open-usage
			return 1
			;;
		esac
	done
	shift `expr $OPTIND - 1`
	local dev="${1:-${GDSH_DEV:?'gds-open: no device specified'}}" || return 1

	#
	# TODO: For USB: Select hardware handshake
	#
	#[ $# -gt 1 ] && type="s"	# force serial parameters if some
					# are given on the command line
	if [ "$type" = '?' ] ; then
		type="s"
		case "$dev" in
		*ACM*|*USB*|*ttyU*)
			type="u"
			;;
		esac
	fi
	local baud
	local parity
	local stopbits
	case "$type" in
	s)
		baud=${2:-19200}	# RS232 baud from argument
		parity=${3:-N}		# RS232 parity
		stopbits=${4:-1}	# RS232 stop bits
		;;
	u)
		# pseudo parameters for USB
		[ $# -gt 1 ] && echo "gds-open: Warning: USB device, ignoring serial parameter(s) $2 $3 $4" >&2
		baud=1152000 	# some drivers understand larger values, e.g.
				# up to 460800, but 115000 should be enough
		parity=N
		stopbits=1
		;;
	*)	echo "gds-open: unknown device type $type set in \$GDSH_DEV_TYPE (only u, s, or ? are allowed)" >&2
		return 2
		;;
	esac

	local pArg="-parenb -ignpar -inpck" # no parity
	case "$parity" in 
	n|N)	 
		;;
	e|E)	pArg="parenb -parodd ignpar inpck"
		;;
	o|O)	pArg="parenb parodd ignpar inpck"
		;;
	*)	_gds-open-usage
		echo "gds-open: unsupported parity (only n, N, e, E, o, O are supported)" >&2
		return 1
		;;
	esac

	local sArg="-cstopb"	# 1 stopbit
	case "$stopbits" in 
	1)	
		;;
	2)	sArg="cstopb"
		;;
	*)	_gds-open-usage
		echo "gds-open: unsupported number of stop bits (only 1 and 2 are supported)" >&2
		return 1
		;;
	esac

	exec 9<>"$dev" || return 1
	# TODO: Sort out unneeded options
	stty	\
		$baud	\
		clocal	\
		cread	\
		-crtscts	\
		cs8		\
		$sArg		\
		$pArg		\
		-brkint		\
		-icrnl		\
		ignbrk		\
		-igncr		\
		-inlcr		\
		-istrip		\
		-iuclc		\
		-ixoff		\
		-ixon		\
		-parmrk		\
		ocrnl		\
		-ofdel		\
		-ofill		\
		-olcuc		\
		-onlcr		\
		-onlret		\
		-onocr		\
		-opost		\
		-echo		\
		<&9
	local r=$?
	[ "0$GDSH_DEBUG" -gt 0 ] &&  stty -a <&9
	[ $r -ne 0 ] && gds-close
	if [ -n "$PS1" ] ; then
		if [ $r -eq 0 ] ; then
			echo "[gds-open: $dev $baud $parity $stopbits configured]" >&2
		else
			echo "[gds-open: $dev $baud $parity $stopbits nok]" >&2
		fi
	fi
	return $r
}
#
# .TP
# .B gds-is-open
# Check if the communication device is open.
# .\"

# TODO: Find a way to suppress bash's "bad file descriptor" message in
#	case of error.
gds-is-open () {
	: echo >&9
	local r=$?
	if [ -n "$PS1" ] ; then
		if [ $r -eq 0 ] ; then
			echo '[gds-is-open: device open]' >&2
		else
			echo '[gds-is-open: device not open]' >&2
		fi
	fi
	return $r
}

#
# .TP
# .B gds-close
# Close the oscilloscope's communication device.
# .\"
gds-close () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-close $@" >&2
	exec 9<&-
	exec 9>&-
}

_gds-send () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "_gds-send $@" >&2
	echo "$@" >&9
}

_gds-read () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "_gds-read $@" >&2
	read -t ${GDSH_READ_TIMEOUT:-3} GDSH_RESP <&9
}

##
# .TP
# .B gds-flush
# Read and discard possible oscilloscope output. All output
# that is sent not further apart than one second is discarded.
# .\"
gds-flush () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "_gds-flush $@" >&2
	local dummy
	while read -t 1 dummy <&9
	do
		:
	done
}

##
# .TP
# .B gds-read-silent
# Read a response line from the oscilloscope, but don't
# echo it to standard output. The line is stored in the
# environment variable
# .B $GDSH_RESP
# only.
# .\"
gds-read-silent () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-read-silent $@" >&2
	_gds-read
	local r=$?
	if [ -n "$PS1" ] ; then
		if [ $r -eq 0 ] ; then
			echo '[gds-read-silent: ok, result in $GDSH_RESP]' >&2
		else
			echo '[gds-read-silent: ok]' >&2
		fi
	fi
	return $r
}

##
# .TP
# .B gds-read
# Read a response line from the oscilloscope.
# The response is echoed to standard output and the line is stored
# in the environment variable
# .BR $GDSH_RESP ,
# too.
# .\"
gds-read () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-read $@" >&2
	_gds-read
	local r=$?
	if [ $r -eq 0 ] ; then
		echo "$GDSH_RESP"
	elif [ -n "$PS1" ] ; then
		echo '[gds-read: nok]' >&2
	fi
	return $r
}

##
# .TP
# \fBgds-query-silent\fP \fIquery...\fP
# Send a query, expect a single-line ASCII response in
# .B $GDSH_RESP
# only.
# .\"
gds-query-silent () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-query-silent $@" >&2
	_gds-send "$@" #|| return 1
	gds-read-silent
}

##
# .TP
# \fBgds-query\fP \fIquery...\fP
# Send a query, expect a single-line ASCII response. The response is
# echoed to standard output and also stored in the environment
# variable
# .BR $GDSH_RESP .
# This function is useful in case a direct shell function for some
# query is missing for whatever reasons.
# .\"
gds-query () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-query $@" >&2
	_gds-send "$@" #|| return 1
	gds-read
}


##
# .TP
# \fBgds-query-bin\fP \fIquery\fP [\fIgds-read-bin-arguments\fP]
# Send a query, expect a binary response. The response is converted
# with
# .BR gds-read-bin (1)
# in accordance with the provided
# .IR gds-read-bin-arguments .
# .\"
gds-query-bin () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-query-bin $@" >&2
	if [ "$1" = '-f' ] ; then
		# need to reorder arguments
		local a1="$1"; shift
		local a2="$1"; shift
		local a3="$1"; shift
		set -- "$a3" "$a1" "$a2" "$@"
	fi
	_gds-send "$1" || return 1
	shift
	$GDSH_BINDIR/gds-read-bin "$@" <&9 || { gds-flush; return 1; }
}

##
# .TP
# \fBgds-send\fP (\fIquery\fP|\fIrequest\fP) [\fIarguments...\fP]
# Generic send of a command.
# This function is useful in case a direct shell function for some
# command is missing for whatever reasons.
# .IP
# If the command is a
# .I query
# (indicated by the command ending in '?' or '_', or by the first argument
# being '?' or '_'), then the query is redirected to
# .BR gds-query .
# Else it is assumed the command is a
# .IR request ,
# and the request is just send, without expecting a response.
# .\"
gds-send () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-send $@" >&2
	local cmd="$1"; shift
	local arg="$1"; shift
	[ "$arg" = "_" ] && arg='?'
	if expr "$cmd" : '.*[_?]$' > /dev/null || [ "$arg" = '?' ] ; then
		gds-query "$cmd" "$arg" "$@"
	else
		_gds-send "$cmd" "$arg" "$@"
	fi
}

##
# .TP
# \fBgds-send-bin\fP (\fIquery\fP|\fIrequest\fP) [\fIarguments...\fP]
# Generic send of a command.
# If the command is a
# .I query
# (indicated by the command ending in '?' or '_', or by the first argument
# being '?' or '_'), then the query is redirected to
# .B gds-query-bin
# (expecting a binary response).
# Else it is assumed the command is a
# .IR request ,
# and the request is just send, without expecting a response.
# .\"
gds-send-bin () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-send-bin $@" >&2
	local cmd="$1"; shift
	local arg="$2"; shift
	[ "$arg" = "_" ] && arg='?'
	if expr "$cmd" : '.*[_?]$' > /dev/null || [ "$arg" = '?' ] ; then
		gds-query-bin "$cmd" "$arg" "$@"
	else
		echo "$cmd" "$arg" "$@" >&9
	fi
}

###############################################################################
# High-level functions
###############################################################################

##
# .TP
# \fBgds-measure\fP [\fB-h\fP] [\fB-f\fP] [\fB-s\fP \fIsec\fP] [\fB-p\fP \fItimestamp-format\fP]  [\fB-F\fP \fIfieldsep\fP] (\fIch\fP (\fImeasure...\fP))...
# Obtain one or more measures from the oscilloscope. Either a single set
# of measures or continuous measures can be obtained.
# Run
# .B gds.measure -h
# in
# .BR gdsh (1)
# to get more information.
# .\"

# TODO: Add CSV output format
# TODO: Add gnuplot output format 
# TODO: Add time stamping of outputs (when -f is used)
# TODO: Add column headers (when -f is used)
function _gds-measure-usage () {
	cat >&2 <<!
usage: gds-measure [-h] [-f] [-s <sec>] [-p <timestamp-format>] [-F <fieldsep>]  (<ch> (<measure>...))...
   -h         This help text
   -f         Continuously measure
   -s <sec>   Delay after each round of measures
   -p <timestamp-format>
              Format for the timestamp. See date(1) for format information.
   -F <fieldsep>
              Output field separator. Default: space.
   <ch>	      Separate measurement-channel specification 1 ... 4
   <measure>  Measurement specifications:
      ts            Display a timestamp. See Also -p option.
      D<ch>         Delay channel specification 1 or 2
      tfreq         Trigger-frequency measurement
      <type>[<ch>]  Per-channel measurement. <type>s are:
                    Frequency: freq
                    Voltages:  vamp vav vhi vlo vmax vmin vpp vrms
                    Ratios:    fovs frp pdut rovs rpr
                    Timing:    fall nwid per pwid ris
                    Delays:    fffd ffrd frfd frrd lffd lfrd lrfd lrrd
!
}

gds-measure () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-measure $@" >&2
	local o
	local contflag=0
	local slptime=0
	local ch='1'
	local cmds=""
	local tsf="%s"	# default timestamp format: seconds since epoch
	local fieldsep=" "
	
	OPTIND=1
	while getopts "hfs:p:F:" o
	do
		case "$o" in
		h)
			_gds-measure-usage 2>&1
			return 0
			;;
		f)	contflag=1
			[ "$slptime" -eq 0 ] && slptime=1
			;;
		s)	slptime="$OPTARG"
			;;
		p)	tsf="$OPTARG"
			;;
		F)	fieldsep="$OPTARG"
			;;
		*)
			_gds-measure-usage
			return 2
			;;
		esac
	done
	shift `expr $OPTIND - 1`
	[ $# -lt 1 ] && { _gds-measure-usage; return 1; }

	local nch
	local ch
	local n
	local state=0
	local again=0
	local cfs=""	# current field separator
	while [ $# -gt 0 ] ; do
		case "$1" in
		D1)	# delay channel spec
			cmds="${cmds} :meas:delay1;"
			state=2
			;;
		D2)	# delay channel spec
			cmds="${cmds} :meas:delay2;"
			state=2
			;;
		*1|*2|*3|*4)	# channel spec
			nch=`expr "$1" : '.*\(.\)$'`
			[ "$ch" != "$nch" ] && cmds="${cmds}:meas:sour $nch;"
			ch=$nch
			again=`expr "$1" : '\(.*\).$'`
			shift
			[ -n "$again" ] && set -- "$again" "$@"
			continue
			;;
		tfreq|tf|ft)	# Trigger frequency
			cmds="${cmds}echo -n \"${cfs}ft=\`:trig:freq_\`Hz\";"
			;;
		freq|f)
			cmds="${cmds}echo -n \"${cfs}f${ch}=\`:meas:freq_\`Hz\";"
			;;
		fffd|ffrd|frfd|frrd|lffd|lfrd|lrfd|lrrd)
			# TODO: Delays
			cmds="${cmds}echo -n \"$cfsT$1${ch}=\`:meas:${1}_\`s\";"
			;;
		fall|nwid|per|pwid|ris)
			# Timing
			cmds="${cmds}echo -n \"${cfs}T$1${ch}=\`:meas:${1}_\`s\";"
			;;
		fovs|frp|pdut|rovs|rpr)
			# Ratios
			n=`expr "$1" : '.\(.*\)'`
			cmds="${cmds}echo -n \"${cfs}R$n${ch}=\`:meas:${1}_\`\";"
			;;
		vamp|vav|vhi|vlo|vmax|vmin|vpp|vrms)
			# Voltages
			n=`expr "$1" : '.\(.*\)'`
			cmds="${cmds}echo -n \"${cfs}U$n${ch}=\`:meas:${1}_\`V\";"
			;;
		ts)	# Timestamp
			cmds="${cmds} echo -n \"$cfs\`date '+${tsf}'\`\"; "
			;;
		*)
			_gds-measure-usage
			return 1
			;;
		esac
		shift
		cfs="$fieldsep"
	done
	cmds="${cmds}echo;"	# each measurement interval on a single line
	[ $slptime -ne 0 ]   && cmds="${cmds}sleep $slptime;"
	[ $contflag -ne 0 ]  && cmds="while :;do ${cmds}done;"
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "$cmds" >&2
	eval $cmds
	gds-flush
}


##
# .TP
# .B gds-sync-time
# Synchronize (set) the oscilloscope's time with the current system time.
# .IP
# .B Note:
# The oscilloscope can take up to a minute to display the new time.
# .\"
function gds-sync-time () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-sync-time $@" >&2
	:syst:tim `date +"%H %M %S"`
	[ -n "$PS1" ] && echo "gdsh: Note:  Oscilloscope can take up to a minute to display new time." >&2
}

##
# .TP
# .B gds-sync-date
# Synchronize (set) the oscilloscope's date with the current system date.
# .IP
# .B Note:
# The oscilloscope can take up to a minute to display the new date. The
# date display is only updated when the time display advances to the
# next minute.
# .\"
function gds-sync-date () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-sync-date $@" >&2
	:syst:dat `date +"%d %m %Y"`
	 [ -n "$PS1" ] && echo "gdsh: Note: Oscilloscope can take up to a minute to display new date." >&2
}

##
# .TP
# .B gds-sync
# Synchronize (set) the oscilloscope's date and time with the current
# system date and time.
# .IP
# .B Note:
# The oscilloscope can take up to a minute to display the new values.
# .\"
function gds-sync () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-sync $@" >&2
	gds-sync-date
	gds-sync-time 
}

# [undocumented]
# generate comma separated value data
# similar to the one the SAVE/RECALL function
# the oscilloscope stores in memory, on a USB stick
# Including all the mysterious errors ...
# TODO: Implementation needs to be finished and verified
# .\"
function gds-csv () {
	[ "0$GDSH_DEBUG" -gt 0 ] && echo "gds-cvs $@" >&2
	# TODO: Does this
	# give the right value, or should be taken
	# from the dataset?
	echo "Memory Length,"`:acquire:length_`","

	echo "Trigger Level,"`:trig:lev_`","
	echo "Source,CH$1,"

	# TODO: Can be queried?
	echo "Vertical Units,V,"

	echo "Vertical Scale,"`:chan${1}:scal_`","
	echo "Vertical Position,"`:chan${1}:offs_`","

	# TODO: Can be queried?
	echo "Horizontal Units,s,"
	echo "Horizontal Scale,"`:tim:scal_`","
	echo "Horizontal Position,"`:tim:del_`","
	# TODO: where to get from?
	echo "Horizontal Mode,Main,"
	# TODO: where to get from?
	echo "Sampling Period,?,"

	# Original spelling error "wave" instead of "ware" included
	echo "Firmwave,"`gds-version`

	#
	# TODO: Get the actual data
	#
}

##
# .TP
# .B gds-vendor
# Return oscilloscope vendor. That should usually be the string GW.
# .\"
function gds-vendor () {
	local id=`_idn_`
	local oldifs="$IFS"
	IFS=",$IFS"
	set -- $id
	IFS="$oldifs"
	echo "$1"
}


##
# .TP
# .B gds-type
# Return oscilloscope type.
# .\"
function gds-type () {
	local id=`_idn_`
	local oldifs="$IFS"
	IFS=",$IFS"
	set -- $id
	IFS="$oldifs"
	echo "$2"
}


##
# .TP
# .B gds-serialnum
# Return oscilloscope's serial number.
# .\"
function gds-serialnum () {
	local id=`_idn_`
	local oldifs="$IFS"
	IFS=",$IFS"
	set -- $id
	IFS="$oldifs"
	echo "$3"
}


##
# .TP
# .B gds-version, gds-firmware
# Return oscilloscope's firmware version. Should not be confused with the
# .B gdsh-version
# function.
# .\"
function gds-version () {
	local id=`_idn_`
	local oldifs="$IFS"
	IFS=",$IFS"
	set -- $id
	IFS="$oldifs"
	echo "$4"
}

function gds-firmware() {
	gds-version
}

##
# .TP
# .B gdsh-version
# Return this gdsh's version. Should not be confused with the
# .B gds-version
# function.
# .\"
function gdsh-version () {
	echo "@version@"
}


##
# .TP
# \fBgds-channels\fP [\fB-h\fP] [\fB-e\fP] [\fB-a]
# Return the number of oscilloscope channels or enumerate them.
# Depending on the options the function returns the total number of
# available channels (no option), the above information as an
# enumeration (list) of channel numbers
# .RB ( -e ),
# or an enumeration of the active (turned on) channels 
# .RB ( -a ).
# .IP
# .B Note:
# This information is partly extracted from the oscilloscope type
# information. Changes in firmware, e.g. for OEM versions of the
# oscilloscope, might result in incorrect information.
# .\"
function  _gds-channels-usage () {
	cat >&2 <<-!
		usage: gds-channels [-h] [-a] [-e]
		Number of available oscilloscope channels.
		-h	This help information
		-e	Return list of channel numbers instead
		-a	Return active channel list instead.
	!
}

function gds-channels () {
	local o
	local a=0
	local e=0
	OPTIND=1
	while getopts "aeh" o
	do
		case "$o" in
		a)	a=1 ;;
		e)	e=1 ;;
		h)	_gds-channels-usage 2>&1
			return 0
			;;
		*)	 _gds-channels-usage
			return 1
			;;
		esac
	done
	[ $a -ne 0 -a $e -ne 0 ] && {  _gds-channels-usage; return 1; }
	local tot=$(expr ` gds-type` : '.*\(.\)$')
	if [ $e -ne 0 ] ; then
		local l=""
		local s=""
		while [ "0$tot" -gt 0 ] ; do
			l="$tot$s$l"
			s=" "
			tot=`expr $tot - 1`
		done
		echo $l;
	elif [ $a -ne 0 ] ; then
		local l=""
		local s=""
		while [ "0$tot" -gt 0 ] ; do
			if [ `:chan${tot}:disp_` -ne 0 ] ; then
				l="$tot$s$l"
				s=" "
			fi
			tot=`expr $tot - 1`
		done
		echo $l
	else
		echo $tot
	fi
}


##
# .TP
# .B gds-bandwidth
# Return the bandwidth of the oscilloscope.
# .IP
# .B Note:
# This information is extracted from the oscilloscope type information.
# Changes in firmware, e.g. for OEM versions of the oscilloscope,
# might result in incorrect information.
# .\"
function gds-bandwidth () {
	echo $(($(expr $(gds-type) : '.*\(..\).$') * 10))
}

##
# .TP
# \fBgds-snapshot\fP [\fB-h\fP] [\fB-c\fP \fIcolormap\fP] [\fB-n\fP] [\fIimage.bmp\fP]
# Fetches a screen snapshot from the oscilloscope and stores it
# as a BMP image file, or shows it in the default/configured
# .RB ( GDSH_IMGVIEWER
# environment variable) image viewer for
# .BR gdsh (1).
# .IP
# Run
# .B gds-snapshot -h
# in
# .BR gdsh (1)
# for more information.
# .\"

#
function _gds-snapshot-usage () {
cat  >&2 <<!
usage: gds-snapshot [-h] [-c <colormap>] [-n] [<image.bmp>]
-h	This help information
-c colormap
	Which colormap should be used to create the image.

	standard	Standard (dark) colormap.
	improved	Slightly lighter colormap.
	inksave		Inksave (light) colormap
-n	Do not show graticule or trigger marks.
--	End of options.
<image.bmp>
	Output image file name. If non given a n image viewer is used.#
!
}

function gds-snapshot () {
	local format=1	# use format with graticule and trigger marking
	local colormap=""
	local o
	
	OPTIND=1
	while getopts "hc:n" o
	do
		case "$o" in
		h)	 _gds-snapshot-usage 2>&1
			return 0
			;;
		c)	colormap="-c $OPTARG"
			;;
		n)	format=0
			;;
		*)	 _gds-snapshot-usage
			return 1
			;;
		esac
	done
	shift `expr $OPTIND - 1`
	[ $# -gt 1 ] && { _gds-snapshot-usage; exit 1; }
	:display:output $format
	if  [ $# -eq 1 ] ; then	
		:display:output_ $colormap > "$1" || { rm -f "$1"; exit 1; }
	else
		local file=`mktemp -t gdsh.snapshot.bmp.XXXXXXXX` || exit 1
		:display:output_ $colormap > "$file" || { rm -f "$file"; exit 1; }
		${GDSH_IMGVIEWER:-eog} "$file" &
		# TODO: remove file if no longer needed.
	fi
}


##
# .TP
# \fBgds-plot\fP [\fB-f\fP \fIformat\fP] [\fB-t\fP \fItitle\fP] [\fB-c\fP \fIcomment\fP] [\fIch ...\fP] [\fB--\fP] [\fIfile\fP]
# Plot one or more channel's waveforms.
# This function plots channel waveforms to one of a number of
# output devices in one of a number of formats. It requires
# .BR gnuplot (1).
# All formats/devices as supported by
# .B gnuplot
# are supported by the functions.
# Run
# .B gds-plot -h
# in
# .BR gdsh (1)
# for more information.
# .\"

# TODO: Query offsets, and adjust data
#
function _gds-plot-usage () {
cat  >&2 <<!
usage: gds-plot [-h] [-f <format>] [-t <title>] [-c <comment>] [<ch> ...] [--] [<file>]
-h	This help information
-f <format>
	Output (file) format. Every format supported by installed gnuplot. If
	non given the function tries to guess the format from the extension of
	<file>. If <file> is not given the on-screen X11 window output is
	assumed and -f is ignored.
-t <title>
	Title line. If not given oscilloscope type, current date, time.
-c <comment>
	Comment line. If not given empty.
<ch>	Channels 1 ... 4
--	End of options.
<file>	Output file name. If non given output to screen.
!
}

function gds-plot () {
	local type=`gds-type`	 # Oscilloscope type
	local terminal="x11 title \"$type gds-plot\" enhanced persist"
	local tflag=0
	local file=""
	local title="$type `date`" 
	local o
	local comment=""
	OPTIND=1
	while getopts "c:f:t:" o
	do
		case "$o" in
		c)	comment="\n$OPTARG"
			;;
		f)	terminal="$OPTARG"
			tflag=1
			;;
		t)	title="$OPTARG"
			;;
		h)	 _gds-plot-usage 2>&1
			return 0
			;;
		*)	 _gds-plot-usage
			return 1
			;;
		esac
	done
	shift `expr $OPTIND - 1`

	local channels=""
	while [ $# -gt 0 ] ; do
		case "$1" in
		1|2|3|4) channels="$channels $1"
			;;
		--)	shift
			break
			;;
		*)	break
			;;
		esac
		shift
	done
	[ $# -gt 1 ] && { _gds-plot-usage; return 1; }

	if [ $# -eq 1 ] ; then
		#
		# Get file name. If format is not explicitly set
		# try to guess format from file name for some common
		# file name extensions.
		#
		file="$1"
		if [ "$tflag" -eq 0 ] ; then
			case "$file" in
			*.dxf)	terminal=dxf ;;
			*.fig)	terminal=fig ;;
			*.gif)	terminal="gif enhanced" ;;
			*.jpg|*.jpeg)
				terminal="jpeg enhanced" ;;
			*.png)	terminal="png enhanced" ;;
			*.svg)	terminal="svg enhanced" ;;
			*.ps|*.eps)
				terminal="postscript enhanced" ;;
			# TODO: Add more?
			*)	 _gds-plot-usage
				echo "gds-plot: Use -f to specify format for file $file" >&2
				return 2
				;;
			esac
		fi
	fi

	#
	# query device to get more details
	#
	local i
	if [  -z "$channels" ] ; then
		# get list of active channels if non specified as arguments
		channels=`gds-channels -a`
	else
		# TODO: check if requested channels are active. If not,
		#	either warn and remove channel from list, activate
		#	channel or label channel special.
		:
	fi
	[ -z "$channels" ] && {
		echo "gds-plot: No channel active and no channel defined on command line" >&2
		_gds-plot-usage
		return 1
	}
	local grid=`:disp:grat_` # 0: grid; 1: center cross; 2: off
	local style=`:disp:wav_` # 0: vector; 1: dots
	# TODO: get horizontal mode

	#
	# Prepare plotting command
	#
	local args=""		# assemble pseudo file arguments
	local sep=""
	for i in $channels ; do
		args="$args$sep'-' t \"Ch$i\" ls $i" # TODO: append h,v resolution
		sep=", "
	done
	{
		echo "set terminal $terminal"
		[ -n "$file" ] && echo "set output \"$file\""
		[ "$grid" -eq 0 ] && echo "set grid"
		if [  "$style" -eq 0 ] ; then
			echo "set style data lines"
		else
			#echo "set style data points"
			#echo "set pointsize 0.7"
			echo "set style data dots"
		fi
		cat <<-!
			set xlabel "Time/s" enhanced
			set ylabel "Voltage/V" enhanced
			set style line 1 lt rgb "#ffb000"
			set style line 2 lt rgb "#00ffff"
			set style line 3 lt rgb "#ff00c5"
			set style line 4 lt rgb "#66ff66"
			set title "$title$comment" 
			plot $args
		!
		for i in $channels ; do
			# get data for channel, scale horizontally to interval,
			# scale vertically to vertical resolution
			:acq${i}:mem_ -0 -h -V `:chan${i}:scal_` || return 1
			echo "e"
		done
		cat <<-!
!
	} | ${GDSH_GNUPLOT:-gnuplot} -bg white # ivory
}

[ "0$GDSH_DEBUG" -gt 0 ] && echo "lib/gdsh.functions loaded" >&2
