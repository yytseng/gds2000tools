#!/bin/bash
###############################################################################
# GDS-2000 command shell functions.
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

[ "0$GDSH_DEBUG" -gt 0 ] && echo "Loading lib/gdsh.commands" >&2

# *CLS
# Clear status registers.
*cls () { gds-send '*cls' "$@"; }
_cls () { gds-send '*cls' "$@"; }

# *ESE
# Event status enable register.
*ese () { gds-send '*ese' "$@"; }
_ese () { gds-send '*ese' "$@"; }
*ese? () { gds-query '*ese?' "$@"; }
_ese? () { gds-query '*ese?' "$@"; }
*ese_ () { gds-query '*ese?' "$@"; }
_ese_ () { gds-query '*ese?' "$@"; }

# *ESR
# Standard event status register.
*esr? () { gds-query '*esr?' "$@"; }
_esr? () { gds-query '*esr?' "$@"; }
*esr_ () { gds-query '*esr?' "$@"; }
_esr_ () { gds-query '*esr?' "$@"; }

# *IDN
# Get oscilloscope identification.
*idn? () { gds-query '*idn?' "$@"; }
_idn? () { gds-query '*idn?' "$@"; }
*idn_ () { gds-query '*idn?' "$@"; }
_idn_ () { gds-query '*idn?' "$@"; }

# *LRN
# Get most oscilloscope settings.
*lrn? () { gds-query '*lrn?' "$@"; }
_lrn? () { gds-query '*lrn?' "$@"; }
*lrn_ () { gds-query '*lrn?' "$@"; }
_lrn_ () { gds-query '*lrn?' "$@"; }

# *OPC
# Operation complete bit.
*opc () { gds-send '*opc' "$@"; }
_opc () { gds-send '*opc' "$@"; }
*opc? () { gds-query '*opc?' "$@"; }
_opc? () { gds-query '*opc?' "$@"; }
*opc_ () { gds-query '*opc?' "$@"; }
_opc_ () { gds-query '*opc?' "$@"; }

# *RCL
# Recall settings from memory.
*rcl () { gds-send '*rcl' "$@"; }
_rcl () { gds-send '*rcl' "$@"; }

# *RST
# Reset oscilloscope to factory defaults.
*rst () { gds-send '*rst' "$@"; }
_rst () { gds-send '*rst' "$@"; }

# *SAV
# Store current settings into memory.
*sav () { gds-send '*sav' "$@"; }
_sav () { gds-send '*sav' "$@"; }

# *SRE
# Service request enable register.
*sre () { gds-send '*sre' "$@"; }
_sre () { gds-send '*sre' "$@"; }
*sre? () { gds-query '*sre?' "$@"; }
_sre? () { gds-query '*sre?' "$@"; }
*sre_ () { gds-query '*sre?' "$@"; }
_sre_ () { gds-query '*sre?' "$@"; }

# *STB
# Status byte register.
*stb? () { gds-query '*stb?' "$@"; }
_stb? () { gds-query '*stb?' "$@"; }
*stb_ () { gds-query '*stb?' "$@"; }
_stb_ () { gds-query '*stb?' "$@"; }

# *TRG
# GDS-1000: Manually trigger and display the result. GDS-2000: Undocumented, same as :STOP.
*trg () { gds-send '*trg' "$@"; }
_trg () { gds-send '*trg' "$@"; }

# *WAI
# Wait until all pending overlapped commands are finished.
*wai () { gds-send '*wai' "$@"; }
_wai () { gds-send '*wai' "$@"; }

# :ACQuire:AVERage
# Number of aquisitions for average aquisition.
:acquire:average () { gds-send ':acquire:average' "$@"; }
:acquire:average? () { gds-query ':acquire:average?' "$@"; }
:acquire:average_ () { gds-query ':acquire:average?' "$@"; }
:acq:aver () { gds-send ':acq:aver' "$@"; }
:acq:aver? () { gds-query ':acq:aver?' "$@"; }
:acq:aver_ () { gds-query ':acq:aver?' "$@"; }

# :ACQuire:LENGth
# Number of samples.
:acquire:length () { gds-send ':acquire:length' "$@"; }
:acquire:length? () { gds-query ':acquire:length?' "$@"; }
:acquire:length_ () { gds-query ':acquire:length?' "$@"; }
:acq:leng () { gds-send ':acq:leng' "$@"; }
:acq:leng? () { gds-query ':acq:leng?' "$@"; }
:acq:leng_ () { gds-query ':acq:leng?' "$@"; }

# :ACQuire:MODe
# Aquisition mode.
:acquire:mode () { gds-send ':acquire:mode' "$@"; }
:acquire:mode? () { gds-query ':acquire:mode?' "$@"; }
:acquire:mode_ () { gds-query ':acquire:mode?' "$@"; }
:acq:mod () { gds-send ':acq:mod' "$@"; }
:acq:mod? () { gds-query ':acq:mod?' "$@"; }
:acq:mod_ () { gds-query ':acq:mod?' "$@"; }

# :ACQuire<X>:MEMory
# Read the aquired waveform data.
:acquire1:memory? () { gds-query-bin ':acquire1:memory?' "$@"; }
:acquire1:memory_ () { gds-query-bin ':acquire1:memory?' "$@"; }
:acq1:mem? () { gds-query-bin ':acq1:mem?' "$@"; }
:acq1:mem_ () { gds-query-bin ':acq1:mem?' "$@"; }
:acquire2:memory? () { gds-query-bin ':acquire2:memory?' "$@"; }
:acquire2:memory_ () { gds-query-bin ':acquire2:memory?' "$@"; }
:acq2:mem? () { gds-query-bin ':acq2:mem?' "$@"; }
:acq2:mem_ () { gds-query-bin ':acq2:mem?' "$@"; }
:acquire3:memory? () { gds-query-bin ':acquire3:memory?' "$@"; }
:acquire3:memory_ () { gds-query-bin ':acquire3:memory?' "$@"; }
:acq3:mem? () { gds-query-bin ':acq3:mem?' "$@"; }
:acq3:mem_ () { gds-query-bin ':acq3:mem?' "$@"; }
:acquire4:memory? () { gds-query-bin ':acquire4:memory?' "$@"; }
:acquire4:memory_ () { gds-query-bin ':acquire4:memory?' "$@"; }
:acq4:mem? () { gds-query-bin ':acq4:mem?' "$@"; }
:acq4:mem_ () { gds-query-bin ':acq4:mem?' "$@"; }

# :ACQuire<X>:POINt
# Read the aquired waveform data.
:acquire1:point? () { gds-query-bin ':acquire1:point?' "$@"; }
:acquire1:point_ () { gds-query-bin ':acquire1:point?' "$@"; }
:acq1:poin? () { gds-query-bin ':acq1:poin?' "$@"; }
:acq1:poin_ () { gds-query-bin ':acq1:poin?' "$@"; }
:acquire2:point? () { gds-query-bin ':acquire2:point?' "$@"; }
:acquire2:point_ () { gds-query-bin ':acquire2:point?' "$@"; }
:acq2:poin? () { gds-query-bin ':acq2:poin?' "$@"; }
:acq2:poin_ () { gds-query-bin ':acq2:poin?' "$@"; }
:acquire3:point? () { gds-query-bin ':acquire3:point?' "$@"; }
:acquire3:point_ () { gds-query-bin ':acquire3:point?' "$@"; }
:acq3:poin? () { gds-query-bin ':acq3:poin?' "$@"; }
:acq3:poin_ () { gds-query-bin ':acq3:poin?' "$@"; }
:acquire4:point? () { gds-query-bin ':acquire4:point?' "$@"; }
:acquire4:point_ () { gds-query-bin ':acquire4:point?' "$@"; }
:acq4:poin? () { gds-query-bin ':acq4:poin?' "$@"; }
:acq4:poin_ () { gds-query-bin ':acq4:poin?' "$@"; }

# :AUToset
# Automatic setup.
:autoset () { gds-send ':autoset' "$@"; }
:aut () { gds-send ':aut' "$@"; }

# :CHANnel<X>:BWLimit
# Enable/disable bandwidth limiting.
:channel1:bwlimit () { gds-send ':channel1:bwlimit' "$@"; }
:channel1:bwlimit? () { gds-query ':channel1:bwlimit?' "$@"; }
:channel1:bwlimit_ () { gds-query ':channel1:bwlimit?' "$@"; }
:chan1:bwl () { gds-send ':chan1:bwl' "$@"; }
:chan1:bwl? () { gds-query ':chan1:bwl?' "$@"; }
:chan1:bwl_ () { gds-query ':chan1:bwl?' "$@"; }
:channel2:bwlimit () { gds-send ':channel2:bwlimit' "$@"; }
:channel2:bwlimit? () { gds-query ':channel2:bwlimit?' "$@"; }
:channel2:bwlimit_ () { gds-query ':channel2:bwlimit?' "$@"; }
:chan2:bwl () { gds-send ':chan2:bwl' "$@"; }
:chan2:bwl? () { gds-query ':chan2:bwl?' "$@"; }
:chan2:bwl_ () { gds-query ':chan2:bwl?' "$@"; }
:channel3:bwlimit () { gds-send ':channel3:bwlimit' "$@"; }
:channel3:bwlimit? () { gds-query ':channel3:bwlimit?' "$@"; }
:channel3:bwlimit_ () { gds-query ':channel3:bwlimit?' "$@"; }
:chan3:bwl () { gds-send ':chan3:bwl' "$@"; }
:chan3:bwl? () { gds-query ':chan3:bwl?' "$@"; }
:chan3:bwl_ () { gds-query ':chan3:bwl?' "$@"; }
:channel4:bwlimit () { gds-send ':channel4:bwlimit' "$@"; }
:channel4:bwlimit? () { gds-query ':channel4:bwlimit?' "$@"; }
:channel4:bwlimit_ () { gds-query ':channel4:bwlimit?' "$@"; }
:chan4:bwl () { gds-send ':chan4:bwl' "$@"; }
:chan4:bwl? () { gds-query ':chan4:bwl?' "$@"; }
:chan4:bwl_ () { gds-query ':chan4:bwl?' "$@"; }

# :CHANnel<X>:COUPling
# Measurement coupling.
:channel1:coupling () { gds-send ':channel1:coupling' "$@"; }
:channel1:coupling? () { gds-query ':channel1:coupling?' "$@"; }
:channel1:coupling_ () { gds-query ':channel1:coupling?' "$@"; }
:chan1:coup () { gds-send ':chan1:coup' "$@"; }
:chan1:coup? () { gds-query ':chan1:coup?' "$@"; }
:chan1:coup_ () { gds-query ':chan1:coup?' "$@"; }
:channel2:coupling () { gds-send ':channel2:coupling' "$@"; }
:channel2:coupling? () { gds-query ':channel2:coupling?' "$@"; }
:channel2:coupling_ () { gds-query ':channel2:coupling?' "$@"; }
:chan2:coup () { gds-send ':chan2:coup' "$@"; }
:chan2:coup? () { gds-query ':chan2:coup?' "$@"; }
:chan2:coup_ () { gds-query ':chan2:coup?' "$@"; }
:channel3:coupling () { gds-send ':channel3:coupling' "$@"; }
:channel3:coupling? () { gds-query ':channel3:coupling?' "$@"; }
:channel3:coupling_ () { gds-query ':channel3:coupling?' "$@"; }
:chan3:coup () { gds-send ':chan3:coup' "$@"; }
:chan3:coup? () { gds-query ':chan3:coup?' "$@"; }
:chan3:coup_ () { gds-query ':chan3:coup?' "$@"; }
:channel4:coupling () { gds-send ':channel4:coupling' "$@"; }
:channel4:coupling? () { gds-query ':channel4:coupling?' "$@"; }
:channel4:coupling_ () { gds-query ':channel4:coupling?' "$@"; }
:chan4:coup () { gds-send ':chan4:coup' "$@"; }
:chan4:coup? () { gds-query ':chan4:coup?' "$@"; }
:chan4:coup_ () { gds-query ':chan4:coup?' "$@"; }

# :CHANnel<X>:DISPlay
# Channels to sample and display.
:channel1:display () { gds-send ':channel1:display' "$@"; }
:channel1:display? () { gds-query ':channel1:display?' "$@"; }
:channel1:display_ () { gds-query ':channel1:display?' "$@"; }
:chan1:disp () { gds-send ':chan1:disp' "$@"; }
:chan1:disp? () { gds-query ':chan1:disp?' "$@"; }
:chan1:disp_ () { gds-query ':chan1:disp?' "$@"; }
:channel2:display () { gds-send ':channel2:display' "$@"; }
:channel2:display? () { gds-query ':channel2:display?' "$@"; }
:channel2:display_ () { gds-query ':channel2:display?' "$@"; }
:chan2:disp () { gds-send ':chan2:disp' "$@"; }
:chan2:disp? () { gds-query ':chan2:disp?' "$@"; }
:chan2:disp_ () { gds-query ':chan2:disp?' "$@"; }
:channel3:display () { gds-send ':channel3:display' "$@"; }
:channel3:display? () { gds-query ':channel3:display?' "$@"; }
:channel3:display_ () { gds-query ':channel3:display?' "$@"; }
:chan3:disp () { gds-send ':chan3:disp' "$@"; }
:chan3:disp? () { gds-query ':chan3:disp?' "$@"; }
:chan3:disp_ () { gds-query ':chan3:disp?' "$@"; }
:channel4:display () { gds-send ':channel4:display' "$@"; }
:channel4:display? () { gds-query ':channel4:display?' "$@"; }
:channel4:display_ () { gds-query ':channel4:display?' "$@"; }
:chan4:disp () { gds-send ':chan4:disp' "$@"; }
:chan4:disp? () { gds-query ':chan4:disp?' "$@"; }
:chan4:disp_ () { gds-query ':chan4:disp?' "$@"; }

# :CHANnel<X>:INVert
# Waveform inversion.
:channel1:invert () { gds-send ':channel1:invert' "$@"; }
:channel1:invert? () { gds-query ':channel1:invert?' "$@"; }
:channel1:invert_ () { gds-query ':channel1:invert?' "$@"; }
:chan1:inv () { gds-send ':chan1:inv' "$@"; }
:chan1:inv? () { gds-query ':chan1:inv?' "$@"; }
:chan1:inv_ () { gds-query ':chan1:inv?' "$@"; }
:channel2:invert () { gds-send ':channel2:invert' "$@"; }
:channel2:invert? () { gds-query ':channel2:invert?' "$@"; }
:channel2:invert_ () { gds-query ':channel2:invert?' "$@"; }
:chan2:inv () { gds-send ':chan2:inv' "$@"; }
:chan2:inv? () { gds-query ':chan2:inv?' "$@"; }
:chan2:inv_ () { gds-query ':chan2:inv?' "$@"; }
:channel3:invert () { gds-send ':channel3:invert' "$@"; }
:channel3:invert? () { gds-query ':channel3:invert?' "$@"; }
:channel3:invert_ () { gds-query ':channel3:invert?' "$@"; }
:chan3:inv () { gds-send ':chan3:inv' "$@"; }
:chan3:inv? () { gds-query ':chan3:inv?' "$@"; }
:chan3:inv_ () { gds-query ':chan3:inv?' "$@"; }
:channel4:invert () { gds-send ':channel4:invert' "$@"; }
:channel4:invert? () { gds-query ':channel4:invert?' "$@"; }
:channel4:invert_ () { gds-query ':channel4:invert?' "$@"; }
:chan4:inv () { gds-send ':chan4:inv' "$@"; }
:chan4:inv? () { gds-query ':chan4:inv?' "$@"; }
:chan4:inv_ () { gds-query ':chan4:inv?' "$@"; }

# :CHANnel<X>:MATH
# Math operation selection.
:channel1:math () { gds-send ':channel1:math' "$@"; }
:channel1:math? () { gds-query ':channel1:math?' "$@"; }
:channel1:math_ () { gds-query ':channel1:math?' "$@"; }
:chan1:math () { gds-send ':chan1:math' "$@"; }
:chan1:math? () { gds-query ':chan1:math?' "$@"; }
:chan1:math_ () { gds-query ':chan1:math?' "$@"; }
:channel2:math () { gds-send ':channel2:math' "$@"; }
:channel2:math? () { gds-query ':channel2:math?' "$@"; }
:channel2:math_ () { gds-query ':channel2:math?' "$@"; }
:chan2:math () { gds-send ':chan2:math' "$@"; }
:chan2:math? () { gds-query ':chan2:math?' "$@"; }
:chan2:math_ () { gds-query ':chan2:math?' "$@"; }
:channel3:math () { gds-send ':channel3:math' "$@"; }
:channel3:math? () { gds-query ':channel3:math?' "$@"; }
:channel3:math_ () { gds-query ':channel3:math?' "$@"; }
:chan3:math () { gds-send ':chan3:math' "$@"; }
:chan3:math? () { gds-query ':chan3:math?' "$@"; }
:chan3:math_ () { gds-query ':chan3:math?' "$@"; }
:channel4:math () { gds-send ':channel4:math' "$@"; }
:channel4:math? () { gds-query ':channel4:math?' "$@"; }
:channel4:math_ () { gds-query ':channel4:math?' "$@"; }
:chan4:math () { gds-send ':chan4:math' "$@"; }
:chan4:math? () { gds-query ':chan4:math?' "$@"; }
:chan4:math_ () { gds-query ':chan4:math?' "$@"; }

# :CHANnel<X>:OFFSet
# Vertical display offset.
:channel1:offset () { gds-send ':channel1:offset' "$@"; }
:channel1:offset? () { gds-query ':channel1:offset?' "$@"; }
:channel1:offset_ () { gds-query ':channel1:offset?' "$@"; }
:chan1:offs () { gds-send ':chan1:offs' "$@"; }
:chan1:offs? () { gds-query ':chan1:offs?' "$@"; }
:chan1:offs_ () { gds-query ':chan1:offs?' "$@"; }
:channel2:offset () { gds-send ':channel2:offset' "$@"; }
:channel2:offset? () { gds-query ':channel2:offset?' "$@"; }
:channel2:offset_ () { gds-query ':channel2:offset?' "$@"; }
:chan2:offs () { gds-send ':chan2:offs' "$@"; }
:chan2:offs? () { gds-query ':chan2:offs?' "$@"; }
:chan2:offs_ () { gds-query ':chan2:offs?' "$@"; }
:channel3:offset () { gds-send ':channel3:offset' "$@"; }
:channel3:offset? () { gds-query ':channel3:offset?' "$@"; }
:channel3:offset_ () { gds-query ':channel3:offset?' "$@"; }
:chan3:offs () { gds-send ':chan3:offs' "$@"; }
:chan3:offs? () { gds-query ':chan3:offs?' "$@"; }
:chan3:offs_ () { gds-query ':chan3:offs?' "$@"; }
:channel4:offset () { gds-send ':channel4:offset' "$@"; }
:channel4:offset? () { gds-query ':channel4:offset?' "$@"; }
:channel4:offset_ () { gds-query ':channel4:offset?' "$@"; }
:chan4:offs () { gds-send ':chan4:offs' "$@"; }
:chan4:offs? () { gds-query ':chan4:offs?' "$@"; }
:chan4:offs_ () { gds-query ':chan4:offs?' "$@"; }

# :CHANnel<X>:PROBe
# Probe attenuation factor.
:channel1:probe () { gds-send ':channel1:probe' "$@"; }
:channel1:probe? () { gds-query ':channel1:probe?' "$@"; }
:channel1:probe_ () { gds-query ':channel1:probe?' "$@"; }
:chan1:prob () { gds-send ':chan1:prob' "$@"; }
:chan1:prob? () { gds-query ':chan1:prob?' "$@"; }
:chan1:prob_ () { gds-query ':chan1:prob?' "$@"; }
:channel2:probe () { gds-send ':channel2:probe' "$@"; }
:channel2:probe? () { gds-query ':channel2:probe?' "$@"; }
:channel2:probe_ () { gds-query ':channel2:probe?' "$@"; }
:chan2:prob () { gds-send ':chan2:prob' "$@"; }
:chan2:prob? () { gds-query ':chan2:prob?' "$@"; }
:chan2:prob_ () { gds-query ':chan2:prob?' "$@"; }
:channel3:probe () { gds-send ':channel3:probe' "$@"; }
:channel3:probe? () { gds-query ':channel3:probe?' "$@"; }
:channel3:probe_ () { gds-query ':channel3:probe?' "$@"; }
:chan3:prob () { gds-send ':chan3:prob' "$@"; }
:chan3:prob? () { gds-query ':chan3:prob?' "$@"; }
:chan3:prob_ () { gds-query ':chan3:prob?' "$@"; }
:channel4:probe () { gds-send ':channel4:probe' "$@"; }
:channel4:probe? () { gds-query ':channel4:probe?' "$@"; }
:channel4:probe_ () { gds-query ':channel4:probe?' "$@"; }
:chan4:prob () { gds-send ':chan4:prob' "$@"; }
:chan4:prob? () { gds-query ':chan4:prob?' "$@"; }
:chan4:prob_ () { gds-query ':chan4:prob?' "$@"; }

# :CHANnel<X>:SCALe
# Vertical scale.
:channel1:scale () { gds-send ':channel1:scale' "$@"; }
:channel1:scale? () { gds-query ':channel1:scale?' "$@"; }
:channel1:scale_ () { gds-query ':channel1:scale?' "$@"; }
:chan1:scal () { gds-send ':chan1:scal' "$@"; }
:chan1:scal? () { gds-query ':chan1:scal?' "$@"; }
:chan1:scal_ () { gds-query ':chan1:scal?' "$@"; }
:channel2:scale () { gds-send ':channel2:scale' "$@"; }
:channel2:scale? () { gds-query ':channel2:scale?' "$@"; }
:channel2:scale_ () { gds-query ':channel2:scale?' "$@"; }
:chan2:scal () { gds-send ':chan2:scal' "$@"; }
:chan2:scal? () { gds-query ':chan2:scal?' "$@"; }
:chan2:scal_ () { gds-query ':chan2:scal?' "$@"; }
:channel3:scale () { gds-send ':channel3:scale' "$@"; }
:channel3:scale? () { gds-query ':channel3:scale?' "$@"; }
:channel3:scale_ () { gds-query ':channel3:scale?' "$@"; }
:chan3:scal () { gds-send ':chan3:scal' "$@"; }
:chan3:scal? () { gds-query ':chan3:scal?' "$@"; }
:chan3:scal_ () { gds-query ':chan3:scal?' "$@"; }
:channel4:scale () { gds-send ':channel4:scale' "$@"; }
:channel4:scale? () { gds-query ':channel4:scale?' "$@"; }
:channel4:scale_ () { gds-query ':channel4:scale?' "$@"; }
:chan4:scal () { gds-send ':chan4:scal' "$@"; }
:chan4:scal? () { gds-query ':chan4:scal?' "$@"; }
:chan4:scal_ () { gds-query ':chan4:scal?' "$@"; }

# :COPY
# Generate a hardcopy of the screen.
:copy () { gds-send ':copy' "$@"; }

# :CURSor:SOURce
# Channel for which to measure with cursor.
:cursor:source () { gds-send ':cursor:source' "$@"; }
:cursor:source? () { gds-query ':cursor:source?' "$@"; }
:cursor:source_ () { gds-query ':cursor:source?' "$@"; }
:curs:sour () { gds-send ':curs:sour' "$@"; }
:curs:sour? () { gds-query ':curs:sour?' "$@"; }
:curs:sour_ () { gds-query ':curs:sour?' "$@"; }

# :CURSor:X<X>Position
# Horizontal cursor position.
:cursor:x1position () { gds-send ':cursor:x1position' "$@"; }
:cursor:x1position? () { gds-query ':cursor:x1position?' "$@"; }
:cursor:x1position_ () { gds-query ':cursor:x1position?' "$@"; }
:curs:x1p () { gds-send ':curs:x1p' "$@"; }
:curs:x1p? () { gds-query ':curs:x1p?' "$@"; }
:curs:x1p_ () { gds-query ':curs:x1p?' "$@"; }
:cursor:x2position () { gds-send ':cursor:x2position' "$@"; }
:cursor:x2position? () { gds-query ':cursor:x2position?' "$@"; }
:cursor:x2position_ () { gds-query ':cursor:x2position?' "$@"; }
:curs:x2p () { gds-send ':curs:x2p' "$@"; }
:curs:x2p? () { gds-query ':curs:x2p?' "$@"; }
:curs:x2p_ () { gds-query ':curs:x2p?' "$@"; }

# :CURSor:XDELta
# Difference between the two horizontal cursors.
:cursor:xdelta? () { gds-query ':cursor:xdelta?' "$@"; }
:cursor:xdelta_ () { gds-query ':cursor:xdelta?' "$@"; }
:curs:xdel? () { gds-query ':curs:xdel?' "$@"; }
:curs:xdel_ () { gds-query ':curs:xdel?' "$@"; }

# :CURSor:XDELTa
# Difference between the two horizontal cursors.
:cursor:xdelta? () { gds-query ':cursor:xdelta?' "$@"; }
:cursor:xdelta_ () { gds-query ':cursor:xdelta?' "$@"; }
:curs:xdelt? () { gds-query ':curs:xdelt?' "$@"; }
:curs:xdelt_ () { gds-query ':curs:xdelt?' "$@"; }

# :CURSor:XDISplay
# Horizontal cursor on/off.
:cursor:xdisplay () { gds-send ':cursor:xdisplay' "$@"; }
:cursor:xdisplay? () { gds-query ':cursor:xdisplay?' "$@"; }
:cursor:xdisplay_ () { gds-query ':cursor:xdisplay?' "$@"; }
:curs:xdis () { gds-send ':curs:xdis' "$@"; }
:curs:xdis? () { gds-query ':curs:xdis?' "$@"; }
:curs:xdis_ () { gds-query ':curs:xdis?' "$@"; }

# :CURSor:XDISPlay
# Horizontal cursor on/off.
:cursor:xdisplay () { gds-send ':cursor:xdisplay' "$@"; }
:cursor:xdisplay? () { gds-query ':cursor:xdisplay?' "$@"; }
:cursor:xdisplay_ () { gds-query ':cursor:xdisplay?' "$@"; }
:curs:xdisp () { gds-send ':curs:xdisp' "$@"; }
:curs:xdisp? () { gds-query ':curs:xdisp?' "$@"; }
:curs:xdisp_ () { gds-query ':curs:xdisp?' "$@"; }

# :CURSor:Y<X>Position
# Vertical cursor position.
:cursor:y1position () { gds-send ':cursor:y1position' "$@"; }
:cursor:y1position? () { gds-query ':cursor:y1position?' "$@"; }
:cursor:y1position_ () { gds-query ':cursor:y1position?' "$@"; }
:curs:y1p () { gds-send ':curs:y1p' "$@"; }
:curs:y1p? () { gds-query ':curs:y1p?' "$@"; }
:curs:y1p_ () { gds-query ':curs:y1p?' "$@"; }
:cursor:y2position () { gds-send ':cursor:y2position' "$@"; }
:cursor:y2position? () { gds-query ':cursor:y2position?' "$@"; }
:cursor:y2position_ () { gds-query ':cursor:y2position?' "$@"; }
:curs:y2p () { gds-send ':curs:y2p' "$@"; }
:curs:y2p? () { gds-query ':curs:y2p?' "$@"; }
:curs:y2p_ () { gds-query ':curs:y2p?' "$@"; }

# :CURSor:YDELta
# Difference between the two vertical cursors.
:cursor:ydelta? () { gds-query ':cursor:ydelta?' "$@"; }
:cursor:ydelta_ () { gds-query ':cursor:ydelta?' "$@"; }
:curs:ydel? () { gds-query ':curs:ydel?' "$@"; }
:curs:ydel_ () { gds-query ':curs:ydel?' "$@"; }

# :CURSor:YDELTa
# Difference between the two vertical cursors.
:cursor:ydelta? () { gds-query ':cursor:ydelta?' "$@"; }
:cursor:ydelta_ () { gds-query ':cursor:ydelta?' "$@"; }
:curs:ydelt? () { gds-query ':curs:ydelt?' "$@"; }
:curs:ydelt_ () { gds-query ':curs:ydelt?' "$@"; }

# :CURSor:YDISplay
# Vertical cursor on/off.
:cursor:ydisplay () { gds-send ':cursor:ydisplay' "$@"; }
:cursor:ydisplay? () { gds-query ':cursor:ydisplay?' "$@"; }
:cursor:ydisplay_ () { gds-query ':cursor:ydisplay?' "$@"; }
:curs:ydis () { gds-send ':curs:ydis' "$@"; }
:curs:ydis? () { gds-query ':curs:ydis?' "$@"; }
:curs:ydis_ () { gds-query ':curs:ydis?' "$@"; }

# :CURSor:YDISPlay
# Vertical cursor on/off.
:cursor:ydisplay () { gds-send ':cursor:ydisplay' "$@"; }
:cursor:ydisplay? () { gds-query ':cursor:ydisplay?' "$@"; }
:cursor:ydisplay_ () { gds-query ':cursor:ydisplay?' "$@"; }
:curs:ydisp () { gds-send ':curs:ydisp' "$@"; }
:curs:ydisp? () { gds-query ':curs:ydisp?' "$@"; }
:curs:ydisp_ () { gds-query ':curs:ydisp?' "$@"; }

# :DISPlay:ACCumulate
# Display accumulated waveform data.
:display:accumulate () { gds-send ':display:accumulate' "$@"; }
:display:accumulate? () { gds-query ':display:accumulate?' "$@"; }
:display:accumulate_ () { gds-query ':display:accumulate?' "$@"; }
:disp:acc () { gds-send ':disp:acc' "$@"; }
:disp:acc? () { gds-query ':disp:acc?' "$@"; }
:disp:acc_ () { gds-query ':disp:acc?' "$@"; }

# :DISPlay:CONTrast
# Adjust LCD contrast.
:display:contrast () { gds-send ':display:contrast' "$@"; }
:display:contrast? () { gds-query ':display:contrast?' "$@"; }
:display:contrast_ () { gds-query ':display:contrast?' "$@"; }
:disp:cont () { gds-send ':disp:cont' "$@"; }
:disp:cont? () { gds-query ':disp:cont?' "$@"; }
:disp:cont_ () { gds-query ':disp:cont?' "$@"; }

# :DISPlay:CONTrast:DATa
# Set LCD contrast (GDS-8x0 only)
:display:contrast:data () { gds-send ':display:contrast:data' "$@"; }
:display:contrast:data? () { gds-query ':display:contrast:data?' "$@"; }
:display:contrast:data_ () { gds-query ':display:contrast:data?' "$@"; }
:disp:cont:dat () { gds-send ':disp:cont:dat' "$@"; }
:disp:cont:dat? () { gds-query ':disp:cont:dat?' "$@"; }
:disp:cont:dat_ () { gds-query ':disp:cont:dat?' "$@"; }

# :DISPlay:GRATicule
# Display grid style.
:display:graticule () { gds-send ':display:graticule' "$@"; }
:display:graticule? () { gds-query ':display:graticule?' "$@"; }
:display:graticule_ () { gds-query ':display:graticule?' "$@"; }
:disp:grat () { gds-send ':disp:grat' "$@"; }
:disp:grat? () { gds-query ':disp:grat?' "$@"; }
:disp:grat_ () { gds-query ':disp:grat?' "$@"; }

# :DISPlay:OUTPut
# Set screen snapshot format or get screen snapshot (undocumented).
:display:output () { gds-send ':display:output' "$@"; }
:display:output? () { gds-query-bin -f outp ':display:output?' "$@"; }
:display:output_ () { gds-query-bin -f outp ':display:output?' "$@"; }
:disp:outp () { gds-send ':disp:outp' "$@"; }
:disp:outp? () { gds-query-bin -f outp ':disp:outp?' "$@"; }
:disp:outp_ () { gds-query-bin -f outp ':disp:outp?' "$@"; }

# :DISPlay:WAVeform
# Waveform drawing mode.
:display:waveform () { gds-send ':display:waveform' "$@"; }
:display:waveform? () { gds-query ':display:waveform?' "$@"; }
:display:waveform_ () { gds-query ':display:waveform?' "$@"; }
:disp:wav () { gds-send ':disp:wav' "$@"; }
:disp:wav? () { gds-query ':disp:wav?' "$@"; }
:disp:wav_ () { gds-query ':disp:wav?' "$@"; }

# :FORCe
# Manually trigger and display signal.
:force () { gds-send ':force' "$@"; }
:forc () { gds-send ':forc' "$@"; }

# :GONogo:CLEar
# Clear go/no-go counters.
:gonogo:clear () { gds-send ':gonogo:clear' "$@"; }
:gon:cle () { gds-send ':gon:cle' "$@"; }

# :GONogo:EXECute
# Start/Stop go/no-go test.
:gonogo:execute () { gds-send ':gonogo:execute' "$@"; }
:gonogo:execute? () { gds-query ':gonogo:execute?' "$@"; }
:gonogo:execute_ () { gds-query ':gonogo:execute?' "$@"; }
:gon:exec () { gds-send ':gon:exec' "$@"; }
:gon:exec? () { gds-query ':gon:exec?' "$@"; }
:gon:exec_ () { gds-query ':gon:exec?' "$@"; }

# :GONogo:FUNCtion
:gonogo:function () { gds-send ':gonogo:function' "$@"; }
:gonogo:function? () { gds-query ':gonogo:function?' "$@"; }
:gonogo:function_ () { gds-query ':gonogo:function?' "$@"; }
:gon:func () { gds-send ':gon:func' "$@"; }
:gon:func? () { gds-query ':gon:func?' "$@"; }
:gon:func_ () { gds-query ':gon:func?' "$@"; }

# :GONogo:NGCount
:gonogo:ngcount? () { gds-query ':gonogo:ngcount?' "$@"; }
:gonogo:ngcount_ () { gds-query ':gonogo:ngcount?' "$@"; }
:gon:ngc? () { gds-query ':gon:ngc?' "$@"; }
:gon:ngc_ () { gds-query ':gon:ngc?' "$@"; }

# :GONogo:NGDefine
:gonogo:ngdefine () { gds-send ':gonogo:ngdefine' "$@"; }
:gonogo:ngdefine? () { gds-query ':gonogo:ngdefine?' "$@"; }
:gonogo:ngdefine_ () { gds-query ':gonogo:ngdefine?' "$@"; }
:gon:ngd () { gds-send ':gon:ngd' "$@"; }
:gon:ngd? () { gds-query ':gon:ngd?' "$@"; }
:gon:ngd_ () { gds-query ':gon:ngd?' "$@"; }

# :GONogo:SOURce
:gonogo:source () { gds-send ':gonogo:source' "$@"; }
:gonogo:source? () { gds-query ':gonogo:source?' "$@"; }
:gonogo:source_ () { gds-query ':gonogo:source?' "$@"; }
:gon:sour () { gds-send ':gon:sour' "$@"; }
:gon:sour? () { gds-query ':gon:sour?' "$@"; }
:gon:sour_ () { gds-query ':gon:sour?' "$@"; }

# :GONogo:VIOLation
:gonogo:violation () { gds-send ':gonogo:violation' "$@"; }
:gonogo:violation? () { gds-query ':gonogo:violation?' "$@"; }
:gonogo:violation_ () { gds-query ':gonogo:violation?' "$@"; }
:gon:viol () { gds-send ':gon:viol' "$@"; }
:gon:viol? () { gds-query ':gon:viol?' "$@"; }
:gon:viol_ () { gds-query ':gon:viol?' "$@"; }

# :HARDcopy:INKSaver
:hardcopy:inksaver () { gds-send ':hardcopy:inksaver' "$@"; }
:hardcopy:inksaver? () { gds-query ':hardcopy:inksaver?' "$@"; }
:hardcopy:inksaver_ () { gds-query ':hardcopy:inksaver?' "$@"; }
:hard:inks () { gds-send ':hard:inks' "$@"; }
:hard:inks? () { gds-query ':hard:inks?' "$@"; }
:hard:inks_ () { gds-query ':hard:inks?' "$@"; }

# :HARDcopy:LAYout
:hardcopy:layout () { gds-send ':hardcopy:layout' "$@"; }
:hardcopy:layout? () { gds-query ':hardcopy:layout?' "$@"; }
:hardcopy:layout_ () { gds-query ':hardcopy:layout?' "$@"; }
:hard:lay () { gds-send ':hard:lay' "$@"; }
:hard:lay? () { gds-query ':hard:lay?' "$@"; }
:hard:lay_ () { gds-query ':hard:lay?' "$@"; }

# :HARDcopy:MODe
:hardcopy:mode () { gds-send ':hardcopy:mode' "$@"; }
:hardcopy:mode? () { gds-query ':hardcopy:mode?' "$@"; }
:hardcopy:mode_ () { gds-query ':hardcopy:mode?' "$@"; }
:hard:mod () { gds-send ':hard:mod' "$@"; }
:hard:mod? () { gds-query ':hard:mod?' "$@"; }
:hard:mod_ () { gds-query ':hard:mod?' "$@"; }

# :HARDcopy:RATio
:hardcopy:ratio () { gds-send ':hardcopy:ratio' "$@"; }
:hardcopy:ratio? () { gds-query ':hardcopy:ratio?' "$@"; }
:hardcopy:ratio_ () { gds-query ':hardcopy:ratio?' "$@"; }
:hard:rat () { gds-send ':hard:rat' "$@"; }
:hard:rat? () { gds-query ':hard:rat?' "$@"; }
:hard:rat_ () { gds-query ':hard:rat?' "$@"; }

# :MEASure:DELAY<X>
# Second source for delay measurements.
:measure:delay1 () { gds-send ':measure:delay1' "$@"; }
:measure:delay1? () { gds-query ':measure:delay1?' "$@"; }
:measure:delay1_ () { gds-query ':measure:delay1?' "$@"; }
:meas:delay1 () { gds-send ':meas:delay1' "$@"; }
:meas:delay1? () { gds-query ':meas:delay1?' "$@"; }
:meas:delay1_ () { gds-query ':meas:delay1?' "$@"; }
:measure:delay2 () { gds-send ':measure:delay2' "$@"; }
:measure:delay2? () { gds-query ':measure:delay2?' "$@"; }
:measure:delay2_ () { gds-query ':measure:delay2?' "$@"; }
:meas:delay2 () { gds-send ':meas:delay2' "$@"; }
:meas:delay2? () { gds-query ':meas:delay2?' "$@"; }
:meas:delay2_ () { gds-query ':meas:delay2?' "$@"; }

# :MEASure:FALL
# First pulse falling edge measurement.
:measure:fall? () { gds-query ':measure:fall?' "$@"; }
:measure:fall_ () { gds-query ':measure:fall?' "$@"; }
:meas:fall? () { gds-query ':meas:fall?' "$@"; }
:meas:fall_ () { gds-query ':meas:fall?' "$@"; }

# :MEASure:FFFDelay
# Delay between two falling edges of two sources.
:measure:fffdelay? () { gds-query ':measure:fffdelay?' "$@"; }
:measure:fffdelay_ () { gds-query ':measure:fffdelay?' "$@"; }
:meas:fffd? () { gds-query ':meas:fffd?' "$@"; }
:meas:fffd_ () { gds-query ':meas:fffd?' "$@"; }

# :MEASure:FFRDelay
# Delay between first falling edge and first rising edge of two sources.
:measure:ffrdelay? () { gds-query ':measure:ffrdelay?' "$@"; }
:measure:ffrdelay_ () { gds-query ':measure:ffrdelay?' "$@"; }
:meas:ffrd? () { gds-query ':meas:ffrd?' "$@"; }
:meas:ffrd_ () { gds-query ':meas:ffrd?' "$@"; }

# :MEASure:FOVShoot
# High to low state low undershot.
:measure:fovshoot? () { gds-query ':measure:fovshoot?' "$@"; }
:measure:fovshoot_ () { gds-query ':measure:fovshoot?' "$@"; }
:meas:fovs? () { gds-query ':meas:fovs?' "$@"; }
:meas:fovs_ () { gds-query ':meas:fovs?' "$@"; }

# :MEASure:FPReshoot
# High to low state high overshot.
:measure:fpreshoot? () { gds-query ':measure:fpreshoot?' "$@"; }
:measure:fpreshoot_ () { gds-query ':measure:fpreshoot?' "$@"; }
:meas:fpr? () { gds-query ':meas:fpr?' "$@"; }
:meas:fpr_ () { gds-query ':meas:fpr?' "$@"; }

# :MEASure:FREQuency
# Estimated signal frequency.
:measure:frequency? () { gds-query ':measure:frequency?' "$@"; }
:measure:frequency_ () { gds-query ':measure:frequency?' "$@"; }
:meas:freq? () { gds-query ':meas:freq?' "$@"; }
:meas:freq_ () { gds-query ':meas:freq?' "$@"; }

# :MEASure:FRFDelay
# Delay between first rising edge and first falling edge of two sources.
:measure:frfdelay? () { gds-query ':measure:frfdelay?' "$@"; }
:measure:frfdelay_ () { gds-query ':measure:frfdelay?' "$@"; }
:meas:frfd? () { gds-query ':meas:frfd?' "$@"; }
:meas:frfd_ () { gds-query ':meas:frfd?' "$@"; }

# :MEASure:FRRDelay
# Delay between first rising edges of two sources.
:measure:frrdelay? () { gds-query ':measure:frrdelay?' "$@"; }
:measure:frrdelay_ () { gds-query ':measure:frrdelay?' "$@"; }
:meas:frrd? () { gds-query ':meas:frrd?' "$@"; }
:meas:frrd_ () { gds-query ':meas:frrd?' "$@"; }

# :MEASure:LFFDelay
# Delay between first falling edge and last falling edge of two sources.
:measure:lffdelay? () { gds-query ':measure:lffdelay?' "$@"; }
:measure:lffdelay_ () { gds-query ':measure:lffdelay?' "$@"; }
:meas:lffd? () { gds-query ':meas:lffd?' "$@"; }
:meas:lffd_ () { gds-query ':meas:lffd?' "$@"; }

# :MEASure:LFRDelay
# Delay between first falling edge and last rising edge of two sources.
:measure:lfrdelay? () { gds-query ':measure:lfrdelay?' "$@"; }
:measure:lfrdelay_ () { gds-query ':measure:lfrdelay?' "$@"; }
:meas:lfrd? () { gds-query ':meas:lfrd?' "$@"; }
:meas:lfrd_ () { gds-query ':meas:lfrd?' "$@"; }

# :MEASure:LRFDelay
# Delay between first rising and last falling edge of two sources.
:measure:lrfdelay? () { gds-query ':measure:lrfdelay?' "$@"; }
:measure:lrfdelay_ () { gds-query ':measure:lrfdelay?' "$@"; }
:meas:lrfd? () { gds-query ':meas:lrfd?' "$@"; }
:meas:lrfd_ () { gds-query ':meas:lrfd?' "$@"; }

# :MEASure:LRRDelay
# Delay between first rising and last rising edge of two sources.
:measure:lrrdelay? () { gds-query ':measure:lrrdelay?' "$@"; }
:measure:lrrdelay_ () { gds-query ':measure:lrrdelay?' "$@"; }
:meas:lrrd? () { gds-query ':meas:lrrd?' "$@"; }
:meas:lrrd_ () { gds-query ':meas:lrrd?' "$@"; }

# :MEASure:NWIDth
# Width of first negative pulse in the waveform.
:measure:nwidth? () { gds-query ':measure:nwidth?' "$@"; }
:measure:nwidth_ () { gds-query ':measure:nwidth?' "$@"; }
:meas:nwid? () { gds-query ':meas:nwid?' "$@"; }
:meas:nwid_ () { gds-query ':meas:nwid?' "$@"; }

# :MEASure:PDUTy
# Duty cycle.
:measure:pduty? () { gds-query ':measure:pduty?' "$@"; }
:measure:pduty_ () { gds-query ':measure:pduty?' "$@"; }
:meas:pdut? () { gds-query ':meas:pdut?' "$@"; }
:meas:pdut_ () { gds-query ':meas:pdut?' "$@"; }

# :MEASure:PERiod
# Signal period.
:measure:period? () { gds-query ':measure:period?' "$@"; }
:measure:period_ () { gds-query ':measure:period?' "$@"; }
:meas:per? () { gds-query ':meas:per?' "$@"; }
:meas:per_ () { gds-query ':meas:per?' "$@"; }

# :MEASure:PWIDth
# Positive pulse width.
:measure:pwidth? () { gds-query ':measure:pwidth?' "$@"; }
:measure:pwidth_ () { gds-query ':measure:pwidth?' "$@"; }
:meas:pwid? () { gds-query ':meas:pwid?' "$@"; }
:meas:pwid_ () { gds-query ':meas:pwid?' "$@"; }

# :MEASure:RISe
# Rising edge time of first pulse.
:measure:rise? () { gds-query ':measure:rise?' "$@"; }
:measure:rise_ () { gds-query ':measure:rise?' "$@"; }
:meas:ris? () { gds-query ':meas:ris?' "$@"; }
:meas:ris_ () { gds-query ':meas:ris?' "$@"; }

# :MEASure:ROVShoot
# Low to high state high overshot.
:measure:rovshoot? () { gds-query ':measure:rovshoot?' "$@"; }
:measure:rovshoot_ () { gds-query ':measure:rovshoot?' "$@"; }
:meas:rovs? () { gds-query ':meas:rovs?' "$@"; }
:meas:rovs_ () { gds-query ':meas:rovs?' "$@"; }

# :MEASure:RPReshoot
# Low to high state low undershot.
:measure:rpreshoot? () { gds-query ':measure:rpreshoot?' "$@"; }
:measure:rpreshoot_ () { gds-query ':measure:rpreshoot?' "$@"; }
:meas:rpr? () { gds-query ':meas:rpr?' "$@"; }
:meas:rpr_ () { gds-query ':meas:rpr?' "$@"; }

# :MEASure:SOURce
# Measurement channel.
:measure:source () { gds-send ':measure:source' "$@"; }
:measure:source? () { gds-query ':measure:source?' "$@"; }
:measure:source_ () { gds-query ':measure:source?' "$@"; }
:meas:sour () { gds-send ':meas:sour' "$@"; }
:meas:sour? () { gds-query ':meas:sour?' "$@"; }
:meas:sour_ () { gds-query ':meas:sour?' "$@"; }

# :MEASure:VAMPlitude
# Amplitude value.
:measure:vamplitude? () { gds-query ':measure:vamplitude?' "$@"; }
:measure:vamplitude_ () { gds-query ':measure:vamplitude?' "$@"; }
:meas:vamp? () { gds-query ':meas:vamp?' "$@"; }
:meas:vamp_ () { gds-query ':meas:vamp?' "$@"; }

# :MEASure:VAVerage
# Average voltage.
:measure:vaverage? () { gds-query ':measure:vaverage?' "$@"; }
:measure:vaverage_ () { gds-query ':measure:vaverage?' "$@"; }
:meas:vav? () { gds-query ':meas:vav?' "$@"; }
:meas:vav_ () { gds-query ':meas:vav?' "$@"; }

# :MEASure:VHI
# Largest voltage in waveform.
:measure:vhi? () { gds-query ':measure:vhi?' "$@"; }
:measure:vhi_ () { gds-query ':measure:vhi?' "$@"; }
:meas:vhi? () { gds-query ':meas:vhi?' "$@"; }
:meas:vhi_ () { gds-query ':meas:vhi?' "$@"; }

# :MEASure:VLO
# Lowest voltage in waveform.
:measure:vlo? () { gds-query ':measure:vlo?' "$@"; }
:measure:vlo_ () { gds-query ':measure:vlo?' "$@"; }
:meas:vlo? () { gds-query ':meas:vlo?' "$@"; }
:meas:vlo_ () { gds-query ':meas:vlo?' "$@"; }

# :MEASure:VMAX
# Maximum value of amplitude.
:measure:vmax? () { gds-query ':measure:vmax?' "$@"; }
:measure:vmax_ () { gds-query ':measure:vmax?' "$@"; }
:meas:vmax? () { gds-query ':meas:vmax?' "$@"; }
:meas:vmax_ () { gds-query ':meas:vmax?' "$@"; }

# :MEASure:VMIN
# Minimum value of amplitude.
:measure:vmin? () { gds-query ':measure:vmin?' "$@"; }
:measure:vmin_ () { gds-query ':measure:vmin?' "$@"; }
:meas:vmin? () { gds-query ':meas:vmin?' "$@"; }
:meas:vmin_ () { gds-query ':meas:vmin?' "$@"; }

# :MEASure:VPP
# Peak-to peak voltage.
:measure:vpp? () { gds-query ':measure:vpp?' "$@"; }
:measure:vpp_ () { gds-query ':measure:vpp?' "$@"; }
:meas:vpp? () { gds-query ':meas:vpp?' "$@"; }
:meas:vpp_ () { gds-query ':meas:vpp?' "$@"; }

# :MEASure:VRMS
# Root mean square voltage of signal.
:measure:vrms? () { gds-query ':measure:vrms?' "$@"; }
:measure:vrms_ () { gds-query ':measure:vrms?' "$@"; }
:meas:vrms? () { gds-query ':meas:vrms?' "$@"; }
:meas:vrms_ () { gds-query ':meas:vrms?' "$@"; }

# :MEMory<X>:RECall:SETup
# Recall saved setup.
:memory1:recall:setup () { gds-send ':memory1:recall:setup' "$@"; }
:mem1:rec:set () { gds-send ':mem1:rec:set' "$@"; }
:memory2:recall:setup () { gds-send ':memory2:recall:setup' "$@"; }
:mem2:rec:set () { gds-send ':mem2:rec:set' "$@"; }
:memory3:recall:setup () { gds-send ':memory3:recall:setup' "$@"; }
:mem3:rec:set () { gds-send ':mem3:rec:set' "$@"; }
:memory4:recall:setup () { gds-send ':memory4:recall:setup' "$@"; }
:mem4:rec:set () { gds-send ':mem4:rec:set' "$@"; }
:memory5:recall:setup () { gds-send ':memory5:recall:setup' "$@"; }
:mem5:rec:set () { gds-send ':mem5:rec:set' "$@"; }
:memory6:recall:setup () { gds-send ':memory6:recall:setup' "$@"; }
:mem6:rec:set () { gds-send ':mem6:rec:set' "$@"; }
:memory7:recall:setup () { gds-send ':memory7:recall:setup' "$@"; }
:mem7:rec:set () { gds-send ':mem7:rec:set' "$@"; }
:memory8:recall:setup () { gds-send ':memory8:recall:setup' "$@"; }
:mem8:rec:set () { gds-send ':mem8:rec:set' "$@"; }
:memory9:recall:setup () { gds-send ':memory9:recall:setup' "$@"; }
:mem9:rec:set () { gds-send ':mem9:rec:set' "$@"; }
:memory10:recall:setup () { gds-send ':memory10:recall:setup' "$@"; }
:mem10:rec:set () { gds-send ':mem10:rec:set' "$@"; }
:memory11:recall:setup () { gds-send ':memory11:recall:setup' "$@"; }
:mem11:rec:set () { gds-send ':mem11:rec:set' "$@"; }
:memory12:recall:setup () { gds-send ':memory12:recall:setup' "$@"; }
:mem12:rec:set () { gds-send ':mem12:rec:set' "$@"; }
:memory13:recall:setup () { gds-send ':memory13:recall:setup' "$@"; }
:mem13:rec:set () { gds-send ':mem13:rec:set' "$@"; }
:memory14:recall:setup () { gds-send ':memory14:recall:setup' "$@"; }
:mem14:rec:set () { gds-send ':mem14:rec:set' "$@"; }
:memory15:recall:setup () { gds-send ':memory15:recall:setup' "$@"; }
:mem15:rec:set () { gds-send ':mem15:rec:set' "$@"; }
:memory16:recall:setup () { gds-send ':memory16:recall:setup' "$@"; }
:mem16:rec:set () { gds-send ':mem16:rec:set' "$@"; }
:memory17:recall:setup () { gds-send ':memory17:recall:setup' "$@"; }
:mem17:rec:set () { gds-send ':mem17:rec:set' "$@"; }
:memory18:recall:setup () { gds-send ':memory18:recall:setup' "$@"; }
:mem18:rec:set () { gds-send ':mem18:rec:set' "$@"; }
:memory19:recall:setup () { gds-send ':memory19:recall:setup' "$@"; }
:mem19:rec:set () { gds-send ':mem19:rec:set' "$@"; }
:memory20:recall:setup () { gds-send ':memory20:recall:setup' "$@"; }
:mem20:rec:set () { gds-send ':mem20:rec:set' "$@"; }

# :MEMory<X>:RECall:WAVeform
# Recall reference waveform.
:memory1:recall:waveform () { gds-send ':memory1:recall:waveform' "$@"; }
:mem1:rec:wav () { gds-send ':mem1:rec:wav' "$@"; }
:memory2:recall:waveform () { gds-send ':memory2:recall:waveform' "$@"; }
:mem2:rec:wav () { gds-send ':mem2:rec:wav' "$@"; }
:memory3:recall:waveform () { gds-send ':memory3:recall:waveform' "$@"; }
:mem3:rec:wav () { gds-send ':mem3:rec:wav' "$@"; }
:memory4:recall:waveform () { gds-send ':memory4:recall:waveform' "$@"; }
:mem4:rec:wav () { gds-send ':mem4:rec:wav' "$@"; }
:memory5:recall:waveform () { gds-send ':memory5:recall:waveform' "$@"; }
:mem5:rec:wav () { gds-send ':mem5:rec:wav' "$@"; }
:memory6:recall:waveform () { gds-send ':memory6:recall:waveform' "$@"; }
:mem6:rec:wav () { gds-send ':mem6:rec:wav' "$@"; }
:memory7:recall:waveform () { gds-send ':memory7:recall:waveform' "$@"; }
:mem7:rec:wav () { gds-send ':mem7:rec:wav' "$@"; }
:memory8:recall:waveform () { gds-send ':memory8:recall:waveform' "$@"; }
:mem8:rec:wav () { gds-send ':mem8:rec:wav' "$@"; }
:memory9:recall:waveform () { gds-send ':memory9:recall:waveform' "$@"; }
:mem9:rec:wav () { gds-send ':mem9:rec:wav' "$@"; }
:memory10:recall:waveform () { gds-send ':memory10:recall:waveform' "$@"; }
:mem10:rec:wav () { gds-send ':mem10:rec:wav' "$@"; }
:memory11:recall:waveform () { gds-send ':memory11:recall:waveform' "$@"; }
:mem11:rec:wav () { gds-send ':mem11:rec:wav' "$@"; }
:memory12:recall:waveform () { gds-send ':memory12:recall:waveform' "$@"; }
:mem12:rec:wav () { gds-send ':mem12:rec:wav' "$@"; }
:memory13:recall:waveform () { gds-send ':memory13:recall:waveform' "$@"; }
:mem13:rec:wav () { gds-send ':mem13:rec:wav' "$@"; }
:memory14:recall:waveform () { gds-send ':memory14:recall:waveform' "$@"; }
:mem14:rec:wav () { gds-send ':mem14:rec:wav' "$@"; }
:memory15:recall:waveform () { gds-send ':memory15:recall:waveform' "$@"; }
:mem15:rec:wav () { gds-send ':mem15:rec:wav' "$@"; }
:memory16:recall:waveform () { gds-send ':memory16:recall:waveform' "$@"; }
:mem16:rec:wav () { gds-send ':mem16:rec:wav' "$@"; }
:memory17:recall:waveform () { gds-send ':memory17:recall:waveform' "$@"; }
:mem17:rec:wav () { gds-send ':mem17:rec:wav' "$@"; }
:memory18:recall:waveform () { gds-send ':memory18:recall:waveform' "$@"; }
:mem18:rec:wav () { gds-send ':mem18:rec:wav' "$@"; }
:memory19:recall:waveform () { gds-send ':memory19:recall:waveform' "$@"; }
:mem19:rec:wav () { gds-send ':mem19:rec:wav' "$@"; }
:memory20:recall:waveform () { gds-send ':memory20:recall:waveform' "$@"; }
:mem20:rec:wav () { gds-send ':mem20:rec:wav' "$@"; }

# :MEMory<X>:SAVe:SETup
# Store current setup.
:memory1:save:setup () { gds-send ':memory1:save:setup' "$@"; }
:mem1:sav:set () { gds-send ':mem1:sav:set' "$@"; }
:memory2:save:setup () { gds-send ':memory2:save:setup' "$@"; }
:mem2:sav:set () { gds-send ':mem2:sav:set' "$@"; }
:memory3:save:setup () { gds-send ':memory3:save:setup' "$@"; }
:mem3:sav:set () { gds-send ':mem3:sav:set' "$@"; }
:memory4:save:setup () { gds-send ':memory4:save:setup' "$@"; }
:mem4:sav:set () { gds-send ':mem4:sav:set' "$@"; }
:memory5:save:setup () { gds-send ':memory5:save:setup' "$@"; }
:mem5:sav:set () { gds-send ':mem5:sav:set' "$@"; }
:memory6:save:setup () { gds-send ':memory6:save:setup' "$@"; }
:mem6:sav:set () { gds-send ':mem6:sav:set' "$@"; }
:memory7:save:setup () { gds-send ':memory7:save:setup' "$@"; }
:mem7:sav:set () { gds-send ':mem7:sav:set' "$@"; }
:memory8:save:setup () { gds-send ':memory8:save:setup' "$@"; }
:mem8:sav:set () { gds-send ':mem8:sav:set' "$@"; }
:memory9:save:setup () { gds-send ':memory9:save:setup' "$@"; }
:mem9:sav:set () { gds-send ':mem9:sav:set' "$@"; }
:memory10:save:setup () { gds-send ':memory10:save:setup' "$@"; }
:mem10:sav:set () { gds-send ':mem10:sav:set' "$@"; }
:memory11:save:setup () { gds-send ':memory11:save:setup' "$@"; }
:mem11:sav:set () { gds-send ':mem11:sav:set' "$@"; }
:memory12:save:setup () { gds-send ':memory12:save:setup' "$@"; }
:mem12:sav:set () { gds-send ':mem12:sav:set' "$@"; }
:memory13:save:setup () { gds-send ':memory13:save:setup' "$@"; }
:mem13:sav:set () { gds-send ':mem13:sav:set' "$@"; }
:memory14:save:setup () { gds-send ':memory14:save:setup' "$@"; }
:mem14:sav:set () { gds-send ':mem14:sav:set' "$@"; }
:memory15:save:setup () { gds-send ':memory15:save:setup' "$@"; }
:mem15:sav:set () { gds-send ':mem15:sav:set' "$@"; }
:memory16:save:setup () { gds-send ':memory16:save:setup' "$@"; }
:mem16:sav:set () { gds-send ':mem16:sav:set' "$@"; }
:memory17:save:setup () { gds-send ':memory17:save:setup' "$@"; }
:mem17:sav:set () { gds-send ':mem17:sav:set' "$@"; }
:memory18:save:setup () { gds-send ':memory18:save:setup' "$@"; }
:mem18:sav:set () { gds-send ':mem18:sav:set' "$@"; }
:memory19:save:setup () { gds-send ':memory19:save:setup' "$@"; }
:mem19:sav:set () { gds-send ':mem19:sav:set' "$@"; }
:memory20:save:setup () { gds-send ':memory20:save:setup' "$@"; }
:mem20:sav:set () { gds-send ':mem20:sav:set' "$@"; }

# :MEMory<X>:SAVe:WAVeform
# Store current waveform.
:memory1:save:waveform () { gds-send ':memory1:save:waveform' "$@"; }
:mem1:sav:wav () { gds-send ':mem1:sav:wav' "$@"; }
:memory2:save:waveform () { gds-send ':memory2:save:waveform' "$@"; }
:mem2:sav:wav () { gds-send ':mem2:sav:wav' "$@"; }
:memory3:save:waveform () { gds-send ':memory3:save:waveform' "$@"; }
:mem3:sav:wav () { gds-send ':mem3:sav:wav' "$@"; }
:memory4:save:waveform () { gds-send ':memory4:save:waveform' "$@"; }
:mem4:sav:wav () { gds-send ':mem4:sav:wav' "$@"; }
:memory5:save:waveform () { gds-send ':memory5:save:waveform' "$@"; }
:mem5:sav:wav () { gds-send ':mem5:sav:wav' "$@"; }
:memory6:save:waveform () { gds-send ':memory6:save:waveform' "$@"; }
:mem6:sav:wav () { gds-send ':mem6:sav:wav' "$@"; }
:memory7:save:waveform () { gds-send ':memory7:save:waveform' "$@"; }
:mem7:sav:wav () { gds-send ':mem7:sav:wav' "$@"; }
:memory8:save:waveform () { gds-send ':memory8:save:waveform' "$@"; }
:mem8:sav:wav () { gds-send ':mem8:sav:wav' "$@"; }
:memory9:save:waveform () { gds-send ':memory9:save:waveform' "$@"; }
:mem9:sav:wav () { gds-send ':mem9:sav:wav' "$@"; }
:memory10:save:waveform () { gds-send ':memory10:save:waveform' "$@"; }
:mem10:sav:wav () { gds-send ':mem10:sav:wav' "$@"; }
:memory11:save:waveform () { gds-send ':memory11:save:waveform' "$@"; }
:mem11:sav:wav () { gds-send ':mem11:sav:wav' "$@"; }
:memory12:save:waveform () { gds-send ':memory12:save:waveform' "$@"; }
:mem12:sav:wav () { gds-send ':mem12:sav:wav' "$@"; }
:memory13:save:waveform () { gds-send ':memory13:save:waveform' "$@"; }
:mem13:sav:wav () { gds-send ':mem13:sav:wav' "$@"; }
:memory14:save:waveform () { gds-send ':memory14:save:waveform' "$@"; }
:mem14:sav:wav () { gds-send ':mem14:sav:wav' "$@"; }
:memory15:save:waveform () { gds-send ':memory15:save:waveform' "$@"; }
:mem15:sav:wav () { gds-send ':mem15:sav:wav' "$@"; }
:memory16:save:waveform () { gds-send ':memory16:save:waveform' "$@"; }
:mem16:sav:wav () { gds-send ':mem16:sav:wav' "$@"; }
:memory17:save:waveform () { gds-send ':memory17:save:waveform' "$@"; }
:mem17:sav:wav () { gds-send ':mem17:sav:wav' "$@"; }
:memory18:save:waveform () { gds-send ':memory18:save:waveform' "$@"; }
:mem18:sav:wav () { gds-send ':mem18:sav:wav' "$@"; }
:memory19:save:waveform () { gds-send ':memory19:save:waveform' "$@"; }
:mem19:sav:wav () { gds-send ':mem19:sav:wav' "$@"; }
:memory20:save:waveform () { gds-send ':memory20:save:waveform' "$@"; }
:mem20:sav:wav () { gds-send ':mem20:sav:wav' "$@"; }

# :PRINt
# Print hardcopy.
:print () { gds-send ':print' "$@"; }
:print? () { gds-query ':print?' "$@"; }
:print_ () { gds-query ':print?' "$@"; }
:prin () { gds-send ':prin' "$@"; }
:prin? () { gds-query ':prin?' "$@"; }
:prin_ () { gds-query ':prin?' "$@"; }

# :REF<X>:DISPlay
# Select and display reference waveform.
:ref1:display () { gds-send ':ref1:display' "$@"; }
:ref1:display? () { gds-query ':ref1:display?' "$@"; }
:ref1:display_ () { gds-query ':ref1:display?' "$@"; }
:ref1:disp () { gds-send ':ref1:disp' "$@"; }
:ref1:disp? () { gds-query ':ref1:disp?' "$@"; }
:ref1:disp_ () { gds-query ':ref1:disp?' "$@"; }
:ref2:display () { gds-send ':ref2:display' "$@"; }
:ref2:display? () { gds-query ':ref2:display?' "$@"; }
:ref2:display_ () { gds-query ':ref2:display?' "$@"; }
:ref2:disp () { gds-send ':ref2:disp' "$@"; }
:ref2:disp? () { gds-query ':ref2:disp?' "$@"; }
:ref2:disp_ () { gds-query ':ref2:disp?' "$@"; }
:ref3:display () { gds-send ':ref3:display' "$@"; }
:ref3:display? () { gds-query ':ref3:display?' "$@"; }
:ref3:display_ () { gds-query ':ref3:display?' "$@"; }
:ref3:disp () { gds-send ':ref3:disp' "$@"; }
:ref3:disp? () { gds-query ':ref3:disp?' "$@"; }
:ref3:disp_ () { gds-query ':ref3:disp?' "$@"; }
:ref4:display () { gds-send ':ref4:display' "$@"; }
:ref4:display? () { gds-query ':ref4:display?' "$@"; }
:ref4:display_ () { gds-query ':ref4:display?' "$@"; }
:ref4:disp () { gds-send ':ref4:disp' "$@"; }
:ref4:disp? () { gds-query ':ref4:disp?' "$@"; }
:ref4:disp_ () { gds-query ':ref4:disp?' "$@"; }

# :REF<X>:LOCate
# Reference waveform storage location.
:ref1:locate () { gds-send ':ref1:locate' "$@"; }
:ref1:locate? () { gds-query ':ref1:locate?' "$@"; }
:ref1:locate_ () { gds-query ':ref1:locate?' "$@"; }
:ref1:loc () { gds-send ':ref1:loc' "$@"; }
:ref1:loc? () { gds-query ':ref1:loc?' "$@"; }
:ref1:loc_ () { gds-query ':ref1:loc?' "$@"; }
:ref2:locate () { gds-send ':ref2:locate' "$@"; }
:ref2:locate? () { gds-query ':ref2:locate?' "$@"; }
:ref2:locate_ () { gds-query ':ref2:locate?' "$@"; }
:ref2:loc () { gds-send ':ref2:loc' "$@"; }
:ref2:loc? () { gds-query ':ref2:loc?' "$@"; }
:ref2:loc_ () { gds-query ':ref2:loc?' "$@"; }
:ref3:locate () { gds-send ':ref3:locate' "$@"; }
:ref3:locate? () { gds-query ':ref3:locate?' "$@"; }
:ref3:locate_ () { gds-query ':ref3:locate?' "$@"; }
:ref3:loc () { gds-send ':ref3:loc' "$@"; }
:ref3:loc? () { gds-query ':ref3:loc?' "$@"; }
:ref3:loc_ () { gds-query ':ref3:loc?' "$@"; }
:ref4:locate () { gds-send ':ref4:locate' "$@"; }
:ref4:locate? () { gds-query ':ref4:locate?' "$@"; }
:ref4:locate_ () { gds-query ':ref4:locate?' "$@"; }
:ref4:loc () { gds-send ':ref4:loc' "$@"; }
:ref4:loc? () { gds-query ':ref4:loc?' "$@"; }
:ref4:loc_ () { gds-query ':ref4:loc?' "$@"; }

# :REF<X>:SAVe
# Save waveform as reference waveform.
:ref1:save () { gds-send ':ref1:save' "$@"; }
:ref1:sav () { gds-send ':ref1:sav' "$@"; }
:ref2:save () { gds-send ':ref2:save' "$@"; }
:ref2:sav () { gds-send ':ref2:sav' "$@"; }
:ref3:save () { gds-send ':ref3:save' "$@"; }
:ref3:sav () { gds-send ':ref3:sav' "$@"; }
:ref4:save () { gds-send ':ref4:save' "$@"; }
:ref4:sav () { gds-send ':ref4:sav' "$@"; }

# :REFResh
# Refresh display.
:refresh () { gds-send ':refresh' "$@"; }
:refr () { gds-send ':refr' "$@"; }

# :RUN
# Run (start trigger).
:run () { gds-send ':run' "$@"; }

# :SINGle
# Select single trigger mode.
:single () { gds-send ':single' "$@"; }
:sing () { gds-send ':sing' "$@"; }

# :STOP
# Stop waiting for a trigger condition. Freeze display.
:stop () { gds-send ':stop' "$@"; }

# :SYSTem:DATe
# Oscilloscope's date.
:system:date () { gds-send ':system:date' "$@"; }
:system:date? () { gds-query ':system:date?' "$@"; }
:system:date_ () { gds-query ':system:date?' "$@"; }
:syst:dat () { gds-send ':syst:dat' "$@"; }
:syst:dat? () { gds-query ':syst:dat?' "$@"; }
:syst:dat_ () { gds-query ':syst:dat?' "$@"; }

# :SYSTem:ERRor
# System error information.
:system:error? () { gds-query ':system:error?' "$@"; }
:system:error_ () { gds-query ':system:error?' "$@"; }
:syst:err? () { gds-query ':syst:err?' "$@"; }
:syst:err_ () { gds-query ':syst:err?' "$@"; }

# :SYSTem:TIMe
# Oscilloscope's time.
:system:time () { gds-send ':system:time' "$@"; }
:system:time? () { gds-query ':system:time?' "$@"; }
:system:time_ () { gds-query ':system:time?' "$@"; }
:syst:tim () { gds-send ':syst:tim' "$@"; }
:syst:tim? () { gds-query ':syst:tim?' "$@"; }
:syst:tim_ () { gds-query ':syst:tim?' "$@"; }

# :SYSTem:UNLock
:system:unlock () { gds-send ':system:unlock' "$@"; }
:system:unlock? () { gds-query ':system:unlock?' "$@"; }
:system:unlock_ () { gds-query ':system:unlock?' "$@"; }
:syst:unl () { gds-send ':syst:unl' "$@"; }
:syst:unl? () { gds-query ':syst:unl?' "$@"; }
:syst:unl_ () { gds-query ':syst:unl?' "$@"; }

# :SYSTem:VERSion
# GDS-2000 series: SCPI version. GDS-1000: Firmware version.
:system:version? () { gds-query ':system:version?' "$@"; }
:system:version_ () { gds-query ':system:version?' "$@"; }
:syst:vers? () { gds-query ':syst:vers?' "$@"; }
:syst:vers_ () { gds-query ':syst:vers?' "$@"; }

# :TEMPlate:MAX
:template:max () { gds-send ':template:max' "$@"; }
:template:max? () { gds-query ':template:max?' "$@"; }
:template:max_ () { gds-query ':template:max?' "$@"; }
:temp:max () { gds-send ':temp:max' "$@"; }
:temp:max? () { gds-query ':temp:max?' "$@"; }
:temp:max_ () { gds-query ':temp:max?' "$@"; }

# :TEMPlate:MIN
:template:min () { gds-send ':template:min' "$@"; }
:template:min? () { gds-query ':template:min?' "$@"; }
:template:min_ () { gds-query ':template:min?' "$@"; }
:temp:min () { gds-send ':temp:min' "$@"; }
:temp:min? () { gds-query ':temp:min?' "$@"; }
:temp:min_ () { gds-query ':temp:min?' "$@"; }

# :TEMPlate:MODe
:template:mode () { gds-send ':template:mode' "$@"; }
:template:mode? () { gds-query ':template:mode?' "$@"; }
:template:mode_ () { gds-query ':template:mode?' "$@"; }
:temp:mod () { gds-send ':temp:mod' "$@"; }
:temp:mod? () { gds-query ':temp:mod?' "$@"; }
:temp:mod_ () { gds-query ':temp:mod?' "$@"; }

# :TEMPlate:POSition:MAX
:template:position:max () { gds-send ':template:position:max' "$@"; }
:template:position:max? () { gds-query ':template:position:max?' "$@"; }
:template:position:max_ () { gds-query ':template:position:max?' "$@"; }
:temp:pos:max () { gds-send ':temp:pos:max' "$@"; }
:temp:pos:max? () { gds-query ':temp:pos:max?' "$@"; }
:temp:pos:max_ () { gds-query ':temp:pos:max?' "$@"; }

# :TEMPlate:POSition:MIN
:template:position:min () { gds-send ':template:position:min' "$@"; }
:template:position:min? () { gds-query ':template:position:min?' "$@"; }
:template:position:min_ () { gds-query ':template:position:min?' "$@"; }
:temp:pos:min () { gds-send ':temp:pos:min' "$@"; }
:temp:pos:min? () { gds-query ':temp:pos:min?' "$@"; }
:temp:pos:min_ () { gds-query ':temp:pos:min?' "$@"; }

# :TEMPlate:SAVe:AUTo
:template:save:auto () { gds-send ':template:save:auto' "$@"; }
:temp:sav:aut () { gds-send ':temp:sav:aut' "$@"; }

# :TEMPlate:SAVe:MAXimum
:template:save:maximum () { gds-send ':template:save:maximum' "$@"; }
:temp:sav:max () { gds-send ':temp:sav:max' "$@"; }

# :TEMPlate:SAVe:MINimum
:template:save:minimum () { gds-send ':template:save:minimum' "$@"; }
:temp:sav:min () { gds-send ':temp:sav:min' "$@"; }

# :TEMPlate:TOLerance
:template:tolerance () { gds-send ':template:tolerance' "$@"; }
:template:tolerance? () { gds-query ':template:tolerance?' "$@"; }
:template:tolerance_ () { gds-query ':template:tolerance?' "$@"; }
:temp:tol () { gds-send ':temp:tol' "$@"; }
:temp:tol? () { gds-query ':temp:tol?' "$@"; }
:temp:tol_ () { gds-query ':temp:tol?' "$@"; }

# :TIMebase:DELay
# Horizontal position.
:timebase:delay () { gds-send ':timebase:delay' "$@"; }
:timebase:delay? () { gds-query ':timebase:delay?' "$@"; }
:timebase:delay_ () { gds-query ':timebase:delay?' "$@"; }
:tim:del () { gds-send ':tim:del' "$@"; }
:tim:del? () { gds-query ':tim:del?' "$@"; }
:tim:del_ () { gds-query ':tim:del?' "$@"; }

# :TIMebase:SCALe
# Horizontal scale.
:timebase:scale () { gds-send ':timebase:scale' "$@"; }
:timebase:scale? () { gds-query ':timebase:scale?' "$@"; }
:timebase:scale_ () { gds-query ':timebase:scale?' "$@"; }
:tim:scal () { gds-send ':tim:scal' "$@"; }
:tim:scal? () { gds-query ':tim:scal?' "$@"; }
:tim:scal_ () { gds-query ':tim:scal?' "$@"; }

# :TIMebase:SWEep
# Horiyontal display mode.
:timebase:sweep () { gds-send ':timebase:sweep' "$@"; }
:timebase:sweep? () { gds-query ':timebase:sweep?' "$@"; }
:timebase:sweep_ () { gds-query ':timebase:sweep?' "$@"; }
:tim:swe () { gds-send ':tim:swe' "$@"; }
:tim:swe? () { gds-query ':tim:swe?' "$@"; }
:tim:swe_ () { gds-query ':tim:swe?' "$@"; }

# :TIMebase:WINDow:DELay
# Horizontal zoom window position.
:timebase:window:delay () { gds-send ':timebase:window:delay' "$@"; }
:timebase:window:delay? () { gds-query ':timebase:window:delay?' "$@"; }
:timebase:window:delay_ () { gds-query ':timebase:window:delay?' "$@"; }
:tim:wind:del () { gds-send ':tim:wind:del' "$@"; }
:tim:wind:del? () { gds-query ':tim:wind:del?' "$@"; }
:tim:wind:del_ () { gds-query ':tim:wind:del?' "$@"; }

# :TIMebase:WINDow:SCALe
# Horizontal zoom window width.
:timebase:window:scale () { gds-send ':timebase:window:scale' "$@"; }
:timebase:window:scale? () { gds-query ':timebase:window:scale?' "$@"; }
:timebase:window:scale_ () { gds-query ':timebase:window:scale?' "$@"; }
:tim:wind:scal () { gds-send ':tim:wind:scal' "$@"; }
:tim:wind:scal? () { gds-query ':tim:wind:scal?' "$@"; }
:tim:wind:scal_ () { gds-query ':tim:wind:scal?' "$@"; }

# :TRIGger:ADVance
:trigger:advance () { gds-send ':trigger:advance' "$@"; }
:trigger:advance? () { gds-query ':trigger:advance?' "$@"; }
:trigger:advance_ () { gds-query ':trigger:advance?' "$@"; }
:trig:adv () { gds-send ':trig:adv' "$@"; }
:trig:adv? () { gds-query ':trig:adv?' "$@"; }
:trig:adv_ () { gds-query ':trig:adv?' "$@"; }

# :TRIGger:COUPle
# Coupling of the trigger.
:trigger:couple () { gds-send ':trigger:couple' "$@"; }
:trigger:couple? () { gds-query ':trigger:couple?' "$@"; }
:trigger:couple_ () { gds-query ':trigger:couple?' "$@"; }
:trig:coup () { gds-send ':trig:coup' "$@"; }
:trig:coup? () { gds-query ':trig:coup?' "$@"; }
:trig:coup_ () { gds-query ':trig:coup?' "$@"; }

# :TRIGger:DELay
:trigger:delay () { gds-send ':trigger:delay' "$@"; }
:trigger:delay? () { gds-query ':trigger:delay?' "$@"; }
:trigger:delay_ () { gds-query ':trigger:delay?' "$@"; }
:trig:del () { gds-send ':trig:del' "$@"; }
:trig:del? () { gds-query ':trig:del?' "$@"; }
:trig:del_ () { gds-query ':trig:del?' "$@"; }

# :TRIGger:DELay:EVENt
# User-defined delay trigger events.
:trigger:delay:event () { gds-send ':trigger:delay:event' "$@"; }
:trigger:delay:event? () { gds-query ':trigger:delay:event?' "$@"; }
:trigger:delay:event_ () { gds-query ':trigger:delay:event?' "$@"; }
:trig:del:even () { gds-send ':trig:del:even' "$@"; }
:trig:del:even? () { gds-query ':trig:del:even?' "$@"; }
:trig:del:even_ () { gds-query ':trig:del:even?' "$@"; }

# :TRIGger:DELay:LEVel
# User-defined trigger level.
:trigger:delay:level () { gds-send ':trigger:delay:level' "$@"; }
:trigger:delay:level? () { gds-query ':trigger:delay:level?' "$@"; }
:trigger:delay:level_ () { gds-query ':trigger:delay:level?' "$@"; }
:trig:del:lev () { gds-send ':trig:del:lev' "$@"; }
:trig:del:lev? () { gds-query ':trig:del:lev?' "$@"; }
:trig:del:lev_ () { gds-query ':trig:del:lev?' "$@"; }

# :TRIGger:DELay:MODe
# Delay mode (user-defined or otherwise)
:trigger:delay:mode () { gds-send ':trigger:delay:mode' "$@"; }
:trigger:delay:mode? () { gds-query ':trigger:delay:mode?' "$@"; }
:trigger:delay:mode_ () { gds-query ':trigger:delay:mode?' "$@"; }
:trig:del:mod () { gds-send ':trig:del:mod' "$@"; }
:trig:del:mod? () { gds-query ':trig:del:mod?' "$@"; }
:trig:del:mod_ () { gds-query ':trig:del:mod?' "$@"; }

# :TRIGger:DELay:TIMe
# User-defined delay trigger time.
:trigger:delay:time () { gds-send ':trigger:delay:time' "$@"; }
:trigger:delay:time? () { gds-query ':trigger:delay:time?' "$@"; }
:trigger:delay:time_ () { gds-query ':trigger:delay:time?' "$@"; }
:trig:del:tim () { gds-send ':trig:del:tim' "$@"; }
:trig:del:tim? () { gds-query ':trig:del:tim?' "$@"; }
:trig:del:tim_ () { gds-query ':trig:del:tim?' "$@"; }

# :TRIGger:DELay:TYPe
# Trigger delay mode (time, event).
:trigger:delay:type () { gds-send ':trigger:delay:type' "$@"; }
:trigger:delay:type? () { gds-query ':trigger:delay:type?' "$@"; }
:trigger:delay:type_ () { gds-query ':trigger:delay:type?' "$@"; }
:trig:del:typ () { gds-send ':trig:del:typ' "$@"; }
:trig:del:typ? () { gds-query ':trig:del:typ?' "$@"; }
:trig:del:typ_ () { gds-query ':trig:del:typ?' "$@"; }

# :TRIGger:EVENt
:trigger:event () { gds-send ':trigger:event' "$@"; }
:trigger:event? () { gds-query ':trigger:event?' "$@"; }
:trigger:event_ () { gds-query ':trigger:event?' "$@"; }
:trig:even () { gds-send ':trig:even' "$@"; }
:trig:even? () { gds-query ':trig:even?' "$@"; }
:trig:even_ () { gds-query ':trig:even?' "$@"; }

# :TRIGger:FIELd
:trigger:field () { gds-send ':trigger:field' "$@"; }
:trigger:field? () { gds-query ':trigger:field?' "$@"; }
:trigger:field_ () { gds-query ':trigger:field?' "$@"; }
:trig:fiel () { gds-send ':trig:fiel' "$@"; }
:trig:fiel? () { gds-query ':trig:fiel?' "$@"; }
:trig:fiel_ () { gds-query ':trig:fiel?' "$@"; }

# :TRIGger:FREQuency
# Trigger frequency.
:trigger:frequency? () { gds-query ':trigger:frequency?' "$@"; }
:trigger:frequency_ () { gds-query ':trigger:frequency?' "$@"; }
:trig:freq? () { gds-query ':trig:freq?' "$@"; }
:trig:freq_ () { gds-query ':trig:freq?' "$@"; }

# :TRIGger:LEVel
# Trigger level.
:trigger:level () { gds-send ':trigger:level' "$@"; }
:trigger:level? () { gds-query ':trigger:level?' "$@"; }
:trigger:level_ () { gds-query ':trigger:level?' "$@"; }
:trig:lev () { gds-send ':trig:lev' "$@"; }
:trig:lev? () { gds-query ':trig:lev?' "$@"; }
:trig:lev_ () { gds-query ':trig:lev?' "$@"; }

# :TRIGger:LINe
:trigger:line () { gds-send ':trigger:line' "$@"; }
:trigger:line? () { gds-query ':trigger:line?' "$@"; }
:trigger:line_ () { gds-query ':trigger:line?' "$@"; }
:trig:lin () { gds-send ':trig:lin' "$@"; }
:trig:lin? () { gds-query ':trig:lin?' "$@"; }
:trig:lin_ () { gds-query ':trig:lin?' "$@"; }

# :TRIGger:MODe
# Trigger mode.
:trigger:mode () { gds-send ':trigger:mode' "$@"; }
:trigger:mode? () { gds-query ':trigger:mode?' "$@"; }
:trigger:mode_ () { gds-query ':trigger:mode?' "$@"; }
:trig:mod () { gds-send ':trig:mod' "$@"; }
:trig:mod? () { gds-query ':trig:mod?' "$@"; }
:trig:mod_ () { gds-query ':trig:mod?' "$@"; }

# :TRIGger:NREJ
# Trigger noise rejection mode.
:trigger:nrej () { gds-send ':trigger:nrej' "$@"; }
:trigger:nrej? () { gds-query ':trigger:nrej?' "$@"; }
:trigger:nrej_ () { gds-query ':trigger:nrej?' "$@"; }
:trig:nrej () { gds-send ':trig:nrej' "$@"; }
:trig:nrej? () { gds-query ':trig:nrej?' "$@"; }
:trig:nrej_ () { gds-query ':trig:nrej?' "$@"; }

# :TRIGger:POLarity
:trigger:polarity () { gds-send ':trigger:polarity' "$@"; }
:trigger:polarity? () { gds-query ':trigger:polarity?' "$@"; }
:trigger:polarity_ () { gds-query ':trigger:polarity?' "$@"; }
:trig:pol () { gds-send ':trig:pol' "$@"; }
:trig:pol? () { gds-query ':trig:pol?' "$@"; }
:trig:pol_ () { gds-query ':trig:pol?' "$@"; }

# :TRIGger:PULSe
:trigger:pulse () { gds-send ':trigger:pulse' "$@"; }
:trigger:pulse? () { gds-query ':trigger:pulse?' "$@"; }
:trigger:pulse_ () { gds-query ':trigger:pulse?' "$@"; }
:trig:puls () { gds-send ':trig:puls' "$@"; }
:trig:puls? () { gds-query ':trig:puls?' "$@"; }
:trig:puls_ () { gds-query ':trig:puls?' "$@"; }

# :TRIGger:PULSe:MODe
# Trigger pulse mode.
:trigger:pulse:mode () { gds-send ':trigger:pulse:mode' "$@"; }
:trigger:pulse:mode? () { gds-query ':trigger:pulse:mode?' "$@"; }
:trigger:pulse:mode_ () { gds-query ':trigger:pulse:mode?' "$@"; }
:trig:puls:mod () { gds-send ':trig:puls:mod' "$@"; }
:trig:puls:mod? () { gds-query ':trig:puls:mod?' "$@"; }
:trig:puls:mod_ () { gds-query ':trig:puls:mod?' "$@"; }

# :TRIGger:PULSe:TIMe
# Tigger pulse width time.
:trigger:pulse:time () { gds-send ':trigger:pulse:time' "$@"; }
:trigger:pulse:time? () { gds-query ':trigger:pulse:time?' "$@"; }
:trigger:pulse:time_ () { gds-query ':trigger:pulse:time?' "$@"; }
:trig:puls:tim () { gds-send ':trig:puls:tim' "$@"; }
:trig:puls:tim? () { gds-query ':trig:puls:tim?' "$@"; }
:trig:puls:tim_ () { gds-query ':trig:puls:tim?' "$@"; }

# :TRIGger:REJect
# Trigger frequency rejection mode.
:trigger:reject () { gds-send ':trigger:reject' "$@"; }
:trigger:reject? () { gds-query ':trigger:reject?' "$@"; }
:trigger:reject_ () { gds-query ':trigger:reject?' "$@"; }
:trig:rej () { gds-send ':trig:rej' "$@"; }
:trig:rej? () { gds-query ':trig:rej?' "$@"; }
:trig:rej_ () { gds-query ':trig:rej?' "$@"; }

# :TRIGger:SLOP
# Trigger detection slope.
:trigger:slop () { gds-send ':trigger:slop' "$@"; }
:trigger:slop? () { gds-query ':trigger:slop?' "$@"; }
:trigger:slop_ () { gds-query ':trigger:slop?' "$@"; }
:trig:slop () { gds-send ':trig:slop' "$@"; }
:trig:slop? () { gds-query ':trig:slop?' "$@"; }
:trig:slop_ () { gds-query ':trig:slop?' "$@"; }

# :TRIGger:SOURce
# Trigger source.
:trigger:source () { gds-send ':trigger:source' "$@"; }
:trigger:source? () { gds-query ':trigger:source?' "$@"; }
:trigger:source_ () { gds-query ':trigger:source?' "$@"; }
:trig:sour () { gds-send ':trig:sour' "$@"; }
:trig:sour? () { gds-query ':trig:sour?' "$@"; }
:trig:sour_ () { gds-query ':trig:sour?' "$@"; }

# :TRIGger:TIMe
:trigger:time () { gds-send ':trigger:time' "$@"; }
:trigger:time? () { gds-query ':trigger:time?' "$@"; }
:trigger:time_ () { gds-query ':trigger:time?' "$@"; }
:trig:tim () { gds-send ':trig:tim' "$@"; }
:trig:tim? () { gds-query ':trig:tim?' "$@"; }
:trig:tim_ () { gds-query ':trig:tim?' "$@"; }

# :TRIGger:TV
:trigger:tv () { gds-send ':trigger:tv' "$@"; }
:trigger:tv? () { gds-query ':trigger:tv?' "$@"; }
:trigger:tv_ () { gds-query ':trigger:tv?' "$@"; }
:trig:tv () { gds-send ':trig:tv' "$@"; }
:trig:tv? () { gds-query ':trig:tv?' "$@"; }
:trig:tv_ () { gds-query ':trig:tv?' "$@"; }

# :TRIGger:TYPe
# Trigger type.
:trigger:type () { gds-send ':trigger:type' "$@"; }
:trigger:type? () { gds-query ':trigger:type?' "$@"; }
:trigger:type_ () { gds-query ':trigger:type?' "$@"; }
:trig:typ () { gds-send ':trig:typ' "$@"; }
:trig:typ? () { gds-query ':trig:typ?' "$@"; }
:trig:typ_ () { gds-query ':trig:typ?' "$@"; }

# :TRIGger:VIDeo:FIELd
# Field on which to trigger in video mode.
:trigger:video:field () { gds-send ':trigger:video:field' "$@"; }
:trigger:video:field? () { gds-query ':trigger:video:field?' "$@"; }
:trigger:video:field_ () { gds-query ':trigger:video:field?' "$@"; }
:trig:vid:fiel () { gds-send ':trig:vid:fiel' "$@"; }
:trig:vid:fiel? () { gds-query ':trig:vid:fiel?' "$@"; }
:trig:vid:fiel_ () { gds-query ':trig:vid:fiel?' "$@"; }

# :TRIGger:VIDeo:LINe
# Video line for triger
:trigger:video:line () { gds-send ':trigger:video:line' "$@"; }
:trigger:video:line? () { gds-query ':trigger:video:line?' "$@"; }
:trigger:video:line_ () { gds-query ':trigger:video:line?' "$@"; }
:trig:vid:lin () { gds-send ':trig:vid:lin' "$@"; }
:trig:vid:lin? () { gds-query ':trig:vid:lin?' "$@"; }
:trig:vid:lin_ () { gds-query ':trig:vid:lin?' "$@"; }

# :TRIGger:VIDeo:POLarity
:trigger:video:polarity () { gds-send ':trigger:video:polarity' "$@"; }
:trigger:video:polarity? () { gds-query ':trigger:video:polarity?' "$@"; }
:trigger:video:polarity_ () { gds-query ':trigger:video:polarity?' "$@"; }
:trig:vid:pol () { gds-send ':trig:vid:pol' "$@"; }
:trig:vid:pol? () { gds-query ':trig:vid:pol?' "$@"; }
:trig:vid:pol_ () { gds-query ':trig:vid:pol?' "$@"; }

# :TRIGger:VIDeo:TYPe
:trigger:video:type () { gds-send ':trigger:video:type' "$@"; }
:trigger:video:type? () { gds-query ':trigger:video:type?' "$@"; }
:trigger:video:type_ () { gds-query ':trigger:video:type?' "$@"; }
:trig:vid:typ () { gds-send ':trig:vid:typ' "$@"; }
:trig:vid:typ? () { gds-query ':trig:vid:typ?' "$@"; }
:trig:vid:typ_ () { gds-query ':trig:vid:typ?' "$@"; }

# :USB:RECall:SETup
:usb:recall:setup () { gds-send ':usb:recall:setup' "$@"; }
:usb:rec:set () { gds-send ':usb:rec:set' "$@"; }

# :USB:RECall:WAVeform
:usb:recall:waveform () { gds-send ':usb:recall:waveform' "$@"; }
:usb:rec:wav () { gds-send ':usb:rec:wav' "$@"; }

# :USB:SAVe:ALL
:usb:save:all () { gds-send ':usb:save:all' "$@"; }
:usb:sav:all () { gds-send ':usb:sav:all' "$@"; }

# :USB:SAVe:IMAGe
:usb:save:image () { gds-send ':usb:save:image' "$@"; }
:usb:sav:imag () { gds-send ':usb:sav:imag' "$@"; }

# :USB:SAVe:SETup
:usb:save:setup () { gds-send ':usb:save:setup' "$@"; }
:usb:sav:set () { gds-send ':usb:sav:set' "$@"; }

# :USB:SAVe:WAVeform
:usb:save:waveform () { gds-send ':usb:save:waveform' "$@"; }
:usb:sav:wav () { gds-send ':usb:sav:wav' "$@"; }

# :WMEMory<X>:DISPlay
# (GDS-8x0 only)
:wmemory1:display () { gds-send ':wmemory1:display' "$@"; }
:wmemory1:display? () { gds-query ':wmemory1:display?' "$@"; }
:wmemory1:display_ () { gds-query ':wmemory1:display?' "$@"; }
:wmem1:disp () { gds-send ':wmem1:disp' "$@"; }
:wmem1:disp? () { gds-query ':wmem1:disp?' "$@"; }
:wmem1:disp_ () { gds-query ':wmem1:disp?' "$@"; }
:wmemory2:display () { gds-send ':wmemory2:display' "$@"; }
:wmemory2:display? () { gds-query ':wmemory2:display?' "$@"; }
:wmemory2:display_ () { gds-query ':wmemory2:display?' "$@"; }
:wmem2:disp () { gds-send ':wmem2:disp' "$@"; }
:wmem2:disp? () { gds-query ':wmem2:disp?' "$@"; }
:wmem2:disp_ () { gds-query ':wmem2:disp?' "$@"; }

# :WMEMory<X>:ERASe
:wmemory1:erase () { gds-send ':wmemory1:erase' "$@"; }
:wmemory1:erase? () { gds-query ':wmemory1:erase?' "$@"; }
:wmemory1:erase_ () { gds-query ':wmemory1:erase?' "$@"; }
:wmem1:eras () { gds-send ':wmem1:eras' "$@"; }
:wmem1:eras? () { gds-query ':wmem1:eras?' "$@"; }
:wmem1:eras_ () { gds-query ':wmem1:eras?' "$@"; }
:wmemory2:erase () { gds-send ':wmemory2:erase' "$@"; }
:wmemory2:erase? () { gds-query ':wmemory2:erase?' "$@"; }
:wmemory2:erase_ () { gds-query ':wmemory2:erase?' "$@"; }
:wmem2:eras () { gds-send ':wmem2:eras' "$@"; }
:wmem2:eras? () { gds-query ':wmem2:eras?' "$@"; }
:wmem2:eras_ () { gds-query ':wmem2:eras?' "$@"; }

# :WMEMory<X>:LOCate
:wmemory1:locate () { gds-send ':wmemory1:locate' "$@"; }
:wmemory1:locate? () { gds-query ':wmemory1:locate?' "$@"; }
:wmemory1:locate_ () { gds-query ':wmemory1:locate?' "$@"; }
:wmem1:loc () { gds-send ':wmem1:loc' "$@"; }
:wmem1:loc? () { gds-query ':wmem1:loc?' "$@"; }
:wmem1:loc_ () { gds-query ':wmem1:loc?' "$@"; }
:wmemory2:locate () { gds-send ':wmemory2:locate' "$@"; }
:wmemory2:locate? () { gds-query ':wmemory2:locate?' "$@"; }
:wmemory2:locate_ () { gds-query ':wmemory2:locate?' "$@"; }
:wmem2:loc () { gds-send ':wmem2:loc' "$@"; }
:wmem2:loc? () { gds-query ':wmem2:loc?' "$@"; }
:wmem2:loc_ () { gds-query ':wmem2:loc?' "$@"; }

# :WMEMory<X>:OFFSet
:wmemory1:offset () { gds-send ':wmemory1:offset' "$@"; }
:wmemory1:offset? () { gds-query ':wmemory1:offset?' "$@"; }
:wmemory1:offset_ () { gds-query ':wmemory1:offset?' "$@"; }
:wmem1:offs () { gds-send ':wmem1:offs' "$@"; }
:wmem1:offs? () { gds-query ':wmem1:offs?' "$@"; }
:wmem1:offs_ () { gds-query ':wmem1:offs?' "$@"; }
:wmemory2:offset () { gds-send ':wmemory2:offset' "$@"; }
:wmemory2:offset? () { gds-query ':wmemory2:offset?' "$@"; }
:wmemory2:offset_ () { gds-query ':wmemory2:offset?' "$@"; }
:wmem2:offs () { gds-send ':wmem2:offs' "$@"; }
:wmem2:offs? () { gds-query ':wmem2:offs?' "$@"; }
:wmem2:offs_ () { gds-query ':wmem2:offs?' "$@"; }

# :WMEMory<X>:SAVe
:wmemory1:save () { gds-send ':wmemory1:save' "$@"; }
:wmemory1:save? () { gds-query ':wmemory1:save?' "$@"; }
:wmemory1:save_ () { gds-query ':wmemory1:save?' "$@"; }
:wmem1:sav () { gds-send ':wmem1:sav' "$@"; }
:wmem1:sav? () { gds-query ':wmem1:sav?' "$@"; }
:wmem1:sav_ () { gds-query ':wmem1:sav?' "$@"; }
:wmemory2:save () { gds-send ':wmemory2:save' "$@"; }
:wmemory2:save? () { gds-query ':wmemory2:save?' "$@"; }
:wmemory2:save_ () { gds-query ':wmemory2:save?' "$@"; }
:wmem2:sav () { gds-send ':wmem2:sav' "$@"; }
:wmem2:sav? () { gds-query ':wmem2:sav?' "$@"; }
:wmem2:sav_ () { gds-query ':wmem2:sav?' "$@"; }


[ "0$GDSH_DEBUG" -gt 0 ] && echo "lib/gdsh.commands loaded" >&2
