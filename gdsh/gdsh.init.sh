#!/bin/bash
###############################################################################
# $Id: gdsh.init.sh,v 1.8 2008/05/23 10:09:06 tw Exp $
# 
# Initialization for gdsh. Used as rcfile argument to bash
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

###############################################################################

export BASH_ENV=

#
# Define the shell's file descriptor to be used for communicating with the
# oscilloscope
#
# TODO: currently not used
export GDS_FD=9

#
# Load command description file and gds-2000 communication
# functions
#
for i in functions commands
do
	f="$GDSH_LIBDIR/gdsh.$i"
	[ -r "$f" ] || { echo "gdsh: $f not found, installation error!"; exit 1; }
	. "$f"
done

#
# Load rc files
# Note: ~/.bashrc should not be used for GDS-2000 specific
#	interactive configurations.  Use ~/.gdshrc instead
#
for i in /etc/bash.bashrc ~/.bashrc ~/.gdshrc
do
	[ -f "$i" ] && . "$i"
done

if [ -z "$PS1" ] ; then
	if [ "0$GDSH_CONNECT_AT_START" -ne 0 -a -n "$GDSH_DEV" ] ; then
		gds-open
	fi
	return
fi

###############################################################################
# Interactive mode only
###############################################################################
PS1='\[\033[01;34m\]gdsh\[\033[00m\]@ '
#PS1='gdsh@ '
PS2='gdsh> '

#
# Say hello to user
#
cat <<!

GDSH v@version@ - [01;30mG[01;31mD[01;32mS[01;33m-[01;34m2000[00m series oscilloscope shell

!

#
# Check if connection at startup is desired
#
if [ "0$GDSH_CONNECT_AT_START" -ne 0 -a -n "$GDSH_DEV" ] ; then
	echo "[gdsh: Trying to open $GDSH_DEV]"
	gds-open
fi
