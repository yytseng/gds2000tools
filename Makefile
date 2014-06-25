###############################################################################
# $Id: Makefile,v 1.10 2008/05/31 00:11:41 tw Exp $
#
# Build and install gds2000tools
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

###############################################################################
# Directories and Subdirectories
###############################################################################
TOP		= .
include $(TOP)/config.mk

GDS_READ_DIR	= gds-read-bin
GDSH_DIR	= gdsh

SUBDIRS		= $(GDS_READ_DIR) $(GDSH_DIR)
.PHONY: $(SUBDIRS)

###############################################################################
# Rules
###############################################################################
default: all
.PHONY: default all

#
# Run subdir commands
# 
all install clean::
	for d in $(SUBDIRS) ; do			\
		 $(MAKE) --directory=$$d $@ || exit 1;	\
	done
