# Readme: ocelot
*forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*

**ocelot:**
"ocelot" is a minimal tiling window manager forked from "monsterwm" with
some functions added and a predefined "config.h" besides the original template
"config.def.h".

## Dependencies

- `xsetbg` (part of xloadimage) to set a wallpaper
- `dzen2` for ocelotbar
- `dmenu` to run stuff with Alt+F2
- `urxvt` to have a terminal with Alt+SHIFT+ENTER
- `i3lock` to lock your screen with Super_L+l

Things to come:
- LCD-brightness control for Thinkpads
- speaker-volume control
- lock screen on lid-close (provided as systemd.unit-file)

Things *NOT* to come:
- Powermanagement: please use `systemd` and `UPower` or your existing setup; ocelot should have no impact on it.

## Install
First make sure ocelots bin-folder is in your `$PATH` or symlinked in a folder
in your `$PATH`. Second compile `ocelot`:
```.sh
make
```

## Configuration
"ocelot" has two user config-files:

**`~/.ocelotrc` for general settings**
```.sh
# needed for dzen2, default is 1366
screen_width=1366

# default path is current directory
ocelot_path="/home/poinck/gits/ocelot/"

# default is no wallpaper
wallpaper="/home/user/path/to/desktop-wallpaper.jpg"
```

**`~/.ocelotbarrc` for additional setting**
```.sh
# if you have a tmd running nearby for local outside temperature
tmd_url="https://yourdomain.tld/path/tm_1.csv"
```

Things to come:
- `glsa-check` notification for Gentoo-users
- `thunderbird` notifications for new mail

### Start ocelot
currently I can only describe the option to use startx

**Start with startx**
Edit `.xinitrc`:
```.sh
exec ocelot2dzen2
```

## Tweaks
You can put any command you would put in a bash-script to tweak your desktop in `.ocelotrc`, here are a few examples I use (many thanks go to the ArchWiki):

**load ICC-Profiles from colord**
```.sh
xcalib -d :0 /usr/share/color/icc/colord/Gamma5500K.icc
```

**natural scrolling**
```.sh
synclient VertScrollDelta=-111
```

**disable rightclick on touchpad**
if you have a decent touchpad with multitouch-support, you will still be able to use right-click with two fingers
```.sh
synclient RightButtonAreaTop=0
synclient RightButtonAreaLeft=0
```

## FAQ

**Will `ocelot` run with wayland?**
If all dependencies and `monsterwm` will support libwayland then I can maybe adjust the intructions to install and setup `ocelot`. Currently I do not plan to port it to libwayland. If you can do it, that'll be great! *(:*

## License
Licensed under MIT/X Consortium License, see [LICENSE][law] file for more
copyright and license information.
- Changes I made after the fork are licensed under CC0 if the MIT-license
permits it

  [law]: https://raw.github.com/c00kiemon5ter/monsterwm/master/LICENSE

## Thanks
- [monsterwm](https://github.com/c00kiemon5ter/monsterwm)


