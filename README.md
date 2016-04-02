# Readme: ocelot
- *forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*
- *I have found out that "monsterwm" is similar to [catwm](https://github.com/pyknite/catwm), it is a catmonster!*

**ocelot:**
"ocelot" is a minimal tiling window manager bundle forked from "monsterwm" with a customized "config.h", side-panel support and a lot of scripts and resources to feel at home right from the start.

*NOTICE: Currently the side-panel is under construction; I recommend to set `PANEL_WIDTH 0` to use top-panel instead.*

![ocelot](/ocelot.png)

## Dependencies
- X11-header files to compile ocelot

Following dependencies are required to get the intended look and feel:
- `xsetbg` (part of xloadimage) to set a wallpaper
- `dzen2` for ocelotbar
- `dmenu` to run stuff
- `urxvt` to have a terminal
- `i3lock` to lock your screen
- `xautolock` to lock screen after some idle time (10 minutes)
- `xbacklight` to control backlight of your notebook screen
- `pacmd` as part of PulseAudio to control volume (sink with index 0) *or*
- `amixer` from alsa to control volume
- *optional* `tmd` to show local temperature, see [tm](https://github.com/poinck/tm)

Things to come (order is priority):
- side-panel, see "./idea" and [THIS](https://poinck.de/screenFetch-2016-02-16_22-45-33.png) awesome screenshot; will use new ocolletcor multiplexer-script
- speaker-volume control (can be done with `pacmd sink-volume 0 0x0C000` or `amixer -q set Master 5%+`*..*`5%-`)
- lock screen on lid-close (provided as systemd.unit-file)
- lock screen before hibernate or standby
- take screenshot, using `scrot`
- move current window to another desktop (still figuring out how this could be done, without compromising stability)
- logging (wrapper-script)
- logging (using journald)

Things *NOT* to come:
- Powermanagement: please use `systemd` and `UPower` or your existing setup; ocelot should have no impact on it.
- save session and restore open application, etc: please use hibernate (suspend to disk) or standby (suspend).

## Install
After you checked out ocelot make sure ocelots bin-folder is in your `$PATH`, otherwise you have to create symlinks to all executable ./bin/o\*-scripts from a folder that is in `$PATH`. Second compile `ocelot` if you are happy with your changes in "config.h":
```.sh
cd /home/$USER
mkdir gits
cd gits
git clone https://github.com/poinck/ocelot.git
cd ocelot
ln -s /home/$USER/gits/ocelot/bin/obrightness ~/bin/obrightness
ln -s /home/$USER/gits/ocelot/bin/ocelot2dzen2 ~/bin/ocelot2dzen2
vim config.h  # look, (change) and :wq
make
```

## Configuration
"ocelot" has two user config-files; create them if you want to change default
behavior:

**`~/.ocelotrc` for general settings:**
See "config/.ocelotrc" for help adjusting the variables.

**`~/.ocelotbarrc` for additional settings:**
See "config/.ocelotbarrc" for help adjusting variables specific to ocelotbar:
- current local temperature

Things to come (order is priority):
- network-indication
- `glsa-check` notification for Gentoo-users
- `thunderbird` notifications for new mail
- display brightness indication (wrapper-script for `xbrightness`)
- CAPSLOCK-indication
- support more than just "BAT0" from `/proc/sys`
- update-indication for `dnf` if you are a Fedora-user
- update-indication for `pacman` if you are an Arch-user
- update-indication for `apt` if you are using a Debian based distribution
- update-indication for `zypper` if you prefer to use `ocelot` with awesome openSUSE (they have chameleons)

### Start ocelot
Currently I can only describe the option to use `startx`.

**`~/.xinitrc`, start with `startx`:**
```.sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
exec ocelot2dzen2
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

**tweaks you can put in `~/.ocelotrc`:**
You can put any command you would put in a bash-script to tweak your desktop in `.ocelotrc`, see "config/.ocelotrc" fo tweaks I use:
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

## FAQ

**Does `ocelot` support multiple monitors?**
Yes and no. You can at least use `xrandr` to mirror your screen output:
- if output does not support native resolution of LVDS1
```.sh
xrandr --output HDMI2 --mode 1280x720 --fb 1366x768 --panning 1366x768 --same-as LVDS1 # --dryrun
```
- if output supports the native resolution of LVDS1
```.sh
xrandr --output HDMI2 --mode 1366x768 --same-as LVDS1 # --dryrun
```

**Will `ocelot` run with wayland?**
If all dependencies and `monsterwm` will support libwayland then I can maybe adjust the instructions to install and setup `ocelot`. Currently I do not plan to port it to libwayland on my own. If you can do it, that'll be great! *(:*

## License
Licensed under MIT/X Consortium License, see [LICENSE][law] file for more
copyright and license information.
- Changes I made after the fork are licensed under CC0 if the MIT-license
permits it

  [law]: https://raw.github.com/c00kiemon5ter/monsterwm/master/LICENSE

## Thanks
- [monsterwm](https://github.com/c00kiemon5ter/monsterwm)


