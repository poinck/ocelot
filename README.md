# Readme: ocelot
- *forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*
- *"monsterwm" is similar to [catwm](https://github.com/pyknite/catwm) and "dwm"*

**ocelot:**
"ocelot" is a minimal tiling window manager bundle forked from "monsterwm" with a customized "config.h" and a side-panel instead of a top-panel.

![ocelot](/ocelot.png)

## Dependencies
- X11-header files to compile ocelot

Following dependencies are required to get the intended look and feel:
- `xsetbg` (part of xloadimage) to set a wallpaper
- `ocelot-dzen` for side-panel, see [ocelot-dzen](https://github.com/poinck/ocelot-dzen)
- `dmenu` to run stuff
- `urxvt` to have a terminal
- `i3lock` to lock your screen
- `xautolock` to lock screen after some idle time (10 minutes)
- `xbacklight` to control backlight of your notebook screen
- `amixer` from alsa to control volume
- *optional* `tmd` to show local temperature, see [tm](https://github.com/poinck/tm)

Things to come (order is priority):
- lock screen on lid-close (provided as systemd.unit-file)
- lock screen before hibernate or standby (provided as systemd-unit-file)
- take screenshot, using `scrot`

Things *NOT* to come:
- Powermanagement: please use your existing setup; ocelot should have no impact on it.
- save session and restore open application, etc: please use hibernate (suspend to disk) or standby (suspend).

## Compile
```.sh
cd /home/$USER
mkdir gits
cd gits
git clone https://github.com/poinck/ocelot.git
cd ocelot
vim config.h  # look, (change) and :wq
make
```

## Install
If you do not plan to install ocelot system-wide, make sure "/home/$USER/bin" is in your `$PATH` and create at least following symlinks:
```.sh
ln -s /home/$USER/gits/ocelot/bin/obrightness ~/bin/obrightness
ln -s /home/$USER/gits/ocelot/bin/ovolume ~/bin/ovolume
ln -s /home/$USER/gits/ocelot/bin/olock ~/bin/olock
ln -s /home/$USER/gits/ocelot/bin/obattery ~/bin/obattery
ln -s /home/$USER/gits/ocelot/bin/startocelot ~/bin/startocelot
ln -s /home/$USER/gits/ocelot/bin/oload ~/bin/oload
```
- additionally you should configure `OCELOT_PATH` in "~/.ocelotrc"

## Configuration
"ocelot" has one user config-file; create it if you want to change default
behavior:

**`~/.ocelotrc` for general settings:**
See "config/.ocelotrc" for help adjusting the variables.

### side-panel TODOs
Things to come (order is priority):
- `glsa-check` indication for Gentoo-users (as box; between "otmc" and "onet")
- disk- and swap-usage (ram, swap, `/` and `/home` as graphs; additional status(?) as box; below cpu-temperature-graph)
- Xinerama-support
- `thunderbird` notifications for new mail
- CAPSLOCK-indication
- support more than just "BAT0" from `/proc/sys`
- update-indication for `dnf` if you are a Fedora-user
- update-indication for `pacman` if you are an Arch-user

### Start ocelot
Currently I can only describe the option to use `startx`.

**`~/.xinitrc`, start with `startx`:**
```.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec startocelot
```

## Security
This section will describe configurations to enhance security of *ocelot*.

**autostart with login from tty; `~/.bashrc`:**
See [X without display manager](https://wiki.gentoo.org/wiki/X_without_Display_Manager#systemd). `exec` will make sure, that the shell cannot be used after ocelot quit or crashed:
```.sh
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
    exec startx
fi
```

## Tweaks
Many thanks go to the Gentoo- and Arch-wiki:

**tweaks you can put in `~/.xinitrc`:**
Copy paste from "tweaks/.xinitrc" for following:
- natural scrolling
- disable right-click on touchpad
- load different ICC-profile from colord

**better reading with `~/.Xresources`:**
Copy paste from "tweaks/.Xresources": This will lighten font colors in the terminal and adds hinting and antialiasing to all applications.

## Keys
How to use `ocelot`? All keyboard-shortcuts can be changed in `config.h` (needs recompile and restart):

- **open terminal** ALT+SHIFT+ENTER
- **open menu** ALT+F2
- **switch desktop** SUPER-L+LEFT|RIGHT
- **lock screen** SUPER-L+l
- **move window** SUPER-L+w|a|s|d
- **resize window** SUPER-L+SHIFT+w|a|s|d
- **select window** ALT+j|k
- **change tiling-mode** ALT+SHIFT+f|t|b|g|m
- **change display brightness** XF86MonBrightnessUp|XF86MonBrightnessDown (FN-Keys)
- **change speaker volume** (FN-Keys)

## FAQ

**Does `ocelot` support multiple monitors?**
Yes and no. Adding Xinerama-support from "monsterwm" is planned. You can at least use `xrandr` to mirror your screen output:
- if output does not support native resolution of LVDS1
```.sh
xrandr --output HDMI2 --mode 1280x720 --fb 1366x768 --panning 1366x768 --same-as LVDS1 # --dryrun
```
- if output supports the native resolution of LVDS1
```.sh
xrandr --output HDMI2 --mode 1366x768 --same-as LVDS1 # --dryrun
```

## License
Licensed under MIT/X Consortium License, see [LICENSE][law] file for more
copyright and license information.
- Changes to existing and new functionality I added after the fork are licensed under CC0 if the MIT-license permits it

  [law]: https://raw.github.com/c00kiemon5ter/monsterwm/master/LICENSE

## Thanks
- [monsterwm](https://github.com/c00kiemon5ter/monsterwm)


