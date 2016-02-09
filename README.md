# Readme: ocelot
*forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*

**ocelot:**
"ocelot" is a minimal tiling window manager forked from "monsterwm" with
some functions added and a predefined "config.h" besides the original template
"config.def.h".

## Dependencies

- `xsetbg` (part of xloadimage) to set a wallpaper
- `dzen2` for ocelotbar
- `dmenu` to run stuff
- `urxvt` to have a terminal
- `i3lock` to lock your screen
- `xautolock` to lock screen after some idle time (10 minutes)

Things to come (order is priority):
- logging (wrapper-script)
- LCD-brightness control for Thinkpads through `/sys`
- speaker-volume control (this will be tricky, I suppose)
- lock screen on lid-close (provided as systemd.unit-file)
- lock screen before hibernate or standby
- `.Xresource`-template to configure colors for `urxvt`
- logging (using journald)
- take screenshot, using `scrot`

Things *NOT* to come:
- Powermanagement: please use `systemd` and `UPower` or your existing setup; ocelot should have no impact on it.
- save session and restore open application, etc: please use hibernate (suspend to disk) or standby (suspend).

## Install
First make sure ocelots bin-folder is in your `$PATH` or symlinked in a folder
in your `$PATH`. Second compile `ocelot`:
```.sh
make
```

## Configuration
"ocelot" has two user config-files; create them if you want to change default
behavior:

**`~/.ocelotrc` for general settings**
```.sh
# needed for dzen2, default is 1366
screen_width=1366

# default path is current directory
ocelot_path="/home/poinck/gits/ocelot/"

# default is no wallpaper
wallpaper="/home/user/path/to/desktop-wallpaper.jpg"
```

**`~/.ocelotbarrc` for additional settings**
```.sh
# if you have a tmd running nearby for local outside temperature
tmd_url="https://yourdomain.tld/path/tm_1.csv"
```

Things to come (order is priority):
- network-indication
- `glsa-check` notification for Gentoo-users
- `thunderbird` notifications for new mail
- support more than just "BAT0" from `/proc/sys`
- update-indication for `dnf` if you are a Fedora-user
- update-indication for `pacman` if you are an Arch-user
- update-indication for `apt` if you are using a Debian based distribution
- update-indication for `zypper` if you prefer to use `ocelot` with awesome openSUSE (they have chameleons)

### Start ocelot
currently I can only describe the option to use `startx`.

**`~/.xinitrc`, start with `startx`**
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

## Keys
How to use `ocelot`? All keyboard-shortcuts can be changed in `config.h` (needs recompile and restart):

- **open terminal** ALT+SHIFT+ENTER
- **open menu** ALT+F2
- **switch desktop** SUPER-L+LEFT|RIGHT
- **lock screen** SUPER-L+l
- **move window** SUPER-L+w|a|s|d
- **resize window** SUPER-L+SHIFT+w|a|s|d
- **seelct window** ALT+j|k
- **change tiling-mode** ALT+SHIFT+f|t|b|g|m

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


