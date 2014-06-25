#!/bin/bash
###############################################################################
# $Id: gdsh.sh,v 1.8 2008/06/22 21:00:10 tw Exp tw $
# Invoke bash with gdsh functions as 'gdsh'
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

mydir=$(dirname "$0")
export GDSH_BINDIR="$mydir/../bin"
export GDSH_LIBDIR="$mydir/../lib"

export GDSH_GNUPLOT=@gnuplot@
export GDSH_IMGVIEWER=@imgviewer@

export BASH_ENV="$GDSH_LIBDIR/gdsh.init"
[ ! -r "$BASH_ENV" ] && { echo "gdsh: Installation error. $BASH_ENV not found." >&2; exit 1; }
#export HISTFILE=~/.gdsh_history
exec bash --rcfile "$BASH_ENV" "$@"
