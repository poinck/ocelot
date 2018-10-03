#!/bin/bash
#
# source this file for elements; currently provides functions for
# - colors
# - debug
#
#    ^   ^
#  +-------+
#  |  o_O  |
#  |  >.<  |__/
#  +-------+
#
# ocelot by André Klausnitzer, CC0

# panel colors
cfont="aaaaaa"
cdarkfont="777777"
cdarkerfont="555555"
cgrey="333333"
cdarkgrey2="292929"
cdarkgrey="1c1c1c"
cdarkblue="3f3f74"
cblue="6767a1"
cdarkpurple="45283c"
cpurple="6e5e69"
cyellow="fbf236"
cdarkyellow="807b1c"
cblueishgrey="cbdbfc"
cblueishdarkgrey="9badb7"
corange="ff683d"
cred="ff2d2d"
cdarkgreen="17451b"
cdarktuerkis="174345"

# shell colors
#             MR:      MB:
C0='\e[30m' # *color0, *color8,  gray/
C1='\e[31m' # *color1, *color9,  orange/ (red)
C2='\e[32m' # *color2, *color10, green/
C3='\e[33m' # *color3, *color11, yellow/
C4='\e[34m' # *color4, *color12, blue/
C5='\e[35m' # *color5, *color13, purple/
C6='\e[36m' # *color6, *color14, cyan/
C7='\e[37m' # *color7, *color15, white/

# shell modifiers
MR='\e[0m' # reset
MB='\e[1m' # bold (lighter)
MI='\e[3m' # italic

debug() {
    msg="$1"
    if [[ "$DEBUG" -eq 1 ]] ; then
        echo "[DEBUG] $msg"
    fi
}

