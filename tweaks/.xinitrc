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
#synclient VertScrollDelta=-111

# natural scrolling for synaptics touchpad using xinput
# "SynPS/2 Synaptics TouchPad", id=11
#   Natural Scrolling Enabled (285): 1
#xinput set-prop 11 285 1

# disable standard rightclick on touchpad
#synclient RightButtonAreaTop=0
#synclient RightButtonAreaLeft=0

# disable standard rightclick for synaptics touchpad using xinput
# "SynPS/2 Synaptics TouchPad", id=11
#   Click Method Enabled (293):  0, 0
#xinput set-prop 11 293 0 0

# set color profile
#xcalib -d :0 /usr/share/color/icc/colord/Gamma5500K.icc

# set a different default X_cursor
xsetroot -cursor_name x_cursor

# improve keyboard rate
xset r rate 300 45

# gdk/gtk scaling for HiDPI devices
# - works for firefox, thunderbird and all GTK3 applications
# - GDK_SCALE is for ui and fonts and GDK_DPI_SCALE is a factor for Xft.dpi
#   from xressources to scale fonts
#export GDK_SCALE=2
#export GDL_DPI_SCALE=0.5

# qt scaling for HiDPI devices
# - works for QT-applications like QGIS
#export QT_SCALE_FACTOR=2

# start dbus and export variables for other programs
if [[ -z "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
    eval `dbus-launch --sh-syntax --exit-with-session`
    echo "dbus session address = $DBUS_SESSION_BUS_ADDRESS"
fi

# start ocelot
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec /home/poinck/gits/ocelot/bin/startocelot

