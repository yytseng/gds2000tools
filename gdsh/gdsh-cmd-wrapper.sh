#!/bin/bash
###############################################################################
# $Id: gdsh-cmd-wrapper.sh,v 1.2 2008/05/15 21:43:22 tw Exp $
# Wrapper to invoke gdsh's functions
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

cmd="\""`basename "$0"`"\""
for i
do
	cmd="$cmd \"$1\""
	shift
done
exec @bindir@/gdsh -c "$cmd"
