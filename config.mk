###############################################################################
# $Id: config.mk,v 1.6 2008/06/22 21:00:10 tw Exp tw $
#
# Configuration of the gds2000tools package.
#
# Copyright (C) 2008 Thomas Weidenfeller
# 
# This file is part of gds2000tools.
# 
# gds2000tools is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
# 
# gds2000tools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with gds2000tools.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################


PREFIX		= /usr/local#		Prefix for installation directories
BINDIR		= $(PREFIX)/bin#	Where to install programs
LIBDIR		= $(PREFIX)/lib#	Where to install library components
MANDIR		= $(PREFIX)/man#	Root of where to install man pages
MAN1DIR		= $(MANDIR)/man1#	Where to install program man pages
MAN7DIR		= $(MANDIR)/man7#	Where to install reference man pages

#
# Helper programs to use
#

GNUPLOT		= gnuplot#		Which gnuplot to use

IMGVIEWER	= eog#			Eye-of-GNOME image viewer

#
# End of installation configuration
###############################################################################

###############################################################################
# Misc. configuration
###############################################################################

VERSION		= 0.3#			gds2000tools version
