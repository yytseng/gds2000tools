###############################################################################
# $Id: Makefile,v 1.22 2008/06/22 21:00:10 tw Exp tw $
#
# Build and install 'gdsh'
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

TOP	= ..
include $(TOP)/config.mk

PRG_SRCS	= gdsh.sh gdsh-cmd-wrapper.sh
LIB_SRCS	= gdsh.functions.sh gdsh.init.sh gdsh.commands.sh
PRGS		= $(PRG_SRCS:.sh=)
LIBS		= $(LIB_SRCS:.sh=)
MANS		= gdsh.1 gdsh.7

#
# Wrappers to generate during installation
#
WRAPPED		=		\
		gds-bandwidth	\
		gds-csv		\
		gds-channels	\
		gds-firmware	\
		gds-flush	\
		gds-measure	\
		gds-plot	\
		gds-query	\
		gds-send	\
		gds-serialnum	\
		gds-snapshot	\
		gds-sync	\
		gds-sync-date	\
		gds-sync-time	\
		gds-type	\
		gds-vendor	\
		gds-version


###############################################################################
# Targets
###############################################################################

default: all
all: $(PRGS) $(LIBS) $(MANS)
.PHONY: default all
clean::
	-rm -f $(PRGS) $(LIBS) 2>/dev/null
.PHONY: clean


#
# Run shell scripts through post-processor to replace variables
# (replace GNU make build-in rule)
# chmod is not needed for our library functions, but it doesn't hurt
#
%: %.sh
	-rm -f $@ 2>/dev/null
	sed 's:@version@:$(VERSION):g; s:@libdir@:$(LIBDIR):g; s:@bindir@:$(BINDIR):g; s:@gnuplot@:$(GNUPLOT):g; s:@imgviewer@:$(IMGVIEWER):g' $< >$@ || { rm -f $@; exit 1; }
	chmod a+x $@

###############################################################################
# Installation
###############################################################################

install: install-bin install-lib install-man
.PHONY: install
install-bin: $(PRGS)
	if [ `id -u` -eq 0 ] ;					\
	then	 						\
		UG="-o bin -g bin";				\
	else 			 				\
		UG="" ;						\
	fi;							\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(BINDIR);	\
	install $(INSTALL_FLAGS) -m 755 $$UG $(PRGS)  $(BINDIR);\
	( cd $(BINDIR);							\
		for i in $(WRAPPED) ;					\
		do							\
			rm -f $$i 2>/dev/null;				\
			ln -f -s  gdsh-cmd-wrapper $$i;			\
		done;							\
	)
.PHONY: install-bin

install-lib: $(LIBS)
	if [ `id -u` -eq 0 ] ;					\
	then	 						\
		UG="-o bin -g bin";				\
	else 							\
		UG="" ;						\
	fi;							\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(LIBDIR);	\
	install $(INSTALL_FLAGS) -m 644 $$UG $(LIBS) $(LIBDIR)
.PHONY: install-lib

install-man: $(MANS)
	if [ `id -u` -eq 0 ] ;					\
	then	 						\
		UG="-o bin -g bin";				\
	else 							\
		UG="" ;						\
	fi;							\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(MAN1DIR); 	\
	install $(INSTALL_FLAGS) -m 644 $$UG gdsh.1 $(MAN1DIR); \
	( cd $(MAN1DIR);						\
		for i in $(WRAPPED) ;					\
		do							\
			rm -f $$i 2>/dev/null;				\
			ln -f -s  gdsh.1 $$i.1;				\
		done;							\
	);								\
	install $(INSTALL_FLAGS) -m 755 $$UG -d $(MAN7DIR);	\
	install $(INSTALL_FLAGS) -m 644 $$UG gdsh.7 $(MAN7DIR)
.PHONY: install-man
