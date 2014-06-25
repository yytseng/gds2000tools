###############################################################################
# $Id: Makefile,v 1.11 2008/06/15 14:18:14 tw Exp $
#
# Build and install 'gds-read-bin'
#
# Copyright (C) 2008 Thomas Weidenfeller
# 
# This file is part of gds2000tools/gds-read-bin.
# 
# gds2000tools/gds-read-bin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License
# version 3 as published by the Free Software Foundation.
# 
# gds2000tools/gds-read-bin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with gds2000tools/gds-read-bin.  If not,
# see <http://www.gnu.org/licenses/>.
###############################################################################

TOP	= ..
include $(TOP)/config.mk

INSTALL_FLAGS =


TARGET	= gds-read-bin
SRCS	= $(TARGET).c memory-list.c snapshot-bmp.c read.c tty.c error.c
HDRS	= $(SRCS:.c=.h)
OBJS	= $(SRCS:.c=.o)

CFLAGS	= -O -Wall

default: all
all: $(TARGET)
.PHONY: default all

$(TARGET): $(OBJS)
clean::
	-$(RM) $(TARGET) $(OBJS) *.bak

###############################################################################
# Installation
#
install: install-bin install-man
install-bin: $(TARGET)
	if [ `id -u` -eq 0 ] ;					\
	then	 						\
		UG="-o bin -g bin";				\
	else 							\
		UG="" ;						\
	fi;							\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(BINDIR);      \
	install $(INSTALL_FLAGS) -m 755 $$UG $(TARGET) $(BINDIR)/$(TARGET)

install-man: $(TARGET).1
	if [ `id -u` -eq 0 ] ;					\
	then	 						\
		UG="-o bin -g bin";				\
	else 							\
		UG="" ;						\
	fi;							\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(MAN1DIR);     \
	install $(INSTALL_FLAGS) -m 644 $$UG $(TARGET).1 $(MAN1DIR)/$(TARGET).1

.PHONY: install install-man install-bin

###############################################################################
# Generate dependency information
#
depend: Makefile.depend
Makefile.depend: Makefile # $(SRCS) $(HDRS)
	$(RM) $@
	$(CC) -MM $(CFLAGS) $(CPPFLAGS) $(SRCS) > $@ || { $(RM) $@; exit 1; }
clean::
	-$(RM) Makefile.depend
.PHONY: depend
-include Makefile.depend

