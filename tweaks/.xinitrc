# natural scrolling on touchpad, recommended if you are used to it
synclient VertScrollDelta=-111

# disable standard rightclick on touchpad, not recommended if you don't own a
# clickable multitouchpad
synclient RightButtonAreaTop=0
synclient RightButtonAreaLeft=0

# set color profile, recommended for blue-ish displays
xcalib -d :0 /usr/share/color/icc/colord/Gamma5500K.icc

# start ocelot
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec startocelot

