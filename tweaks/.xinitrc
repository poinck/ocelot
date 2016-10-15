# HINT: do not replace "~/.xinitrc" with this file, copy what you need instead
#
#    ^   ^
#  +-------+
#  |  o_O  |
#  |  >.<  |__/
#  +-------+
#
# ocelot by André Klausnitzer, CC0

# natural scrolling on touchpad
synclient VertScrollDelta=-111

# natural scrolling for synaptics touchpad using xinput
# "SynPS/2 Synaptics TouchPad", id=11
#   Natural Scrolling Enabled (285): 1
xinput set-prop 11 285 1

# disable standard rightclick on touchpad
synclient RightButtonAreaTop=0
synclient RightButtonAreaLeft=0

# disable standard rightclick for synaptics touchpad using xinput
# "SynPS/2 Synaptics TouchPad", id=11
#   Click Method Enabled (293):  0, 0
xinput set-prop 11 293 0 0

# set color profile
xcalib -d :0 /usr/share/color/icc/colord/Gamma5500K.icc

# disable DPMS if your monitor has other means to save energy (e.g presense
# sensor)
xset s 86400 -dpms

# improve keyboard rate
xset r rate 300 45

# start ocelot
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec /home/poinck/gits/ocelot/bin/startocelot

