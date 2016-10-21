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
- `xrandr` to guess display height

Following is *optional*:
- `tmd` to show local temperature, see [tm](https://github.com/poinck/tm)
- `youtube-dl` and `omxplayer` to use "oyay" to play from video-url supported by youtube-dl on raspberry pi without pre-downloading.

Things to come (order is priority):
- lock screen on lid-close (provided as systemd.unit-file or something else that might do the trick)
- take screenshot, using `scrot`

Things *NOT* to come:
- Powermanagement: please use your existing setup; ocelot should have no impact on it.
- save session and restore open application, etc: please use hibernate (suspend to disk) or standby (suspend).

## Clone, Configure and Compile
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
ln -s /home/$USER/gits/ocelot/bin/oterminal ~/bin/oterminal
ln -s /home/$USER/gits/ocelot/bin/omenu ~/bin/omenu
ln -s /home/$USER/gits/ocelot/bin/oupdates ~/bin/oupdates
ln -s /home/$USER/gits/ocelot/bin/oyay ~/bin/oyay
ln -s /home/$USER/gits/ocelot/bin/oray ~/bin/oray
ln -s /home/$USER/gits/ocelot/bin/olocker ~/bin/olocker
ln -s /home/$USER/gits/ocelot/bin/ocollector ~/bin/ocollector
ln -s /home/$USER/gits/ocelot/bin/odesktop ~/bin/odesktop
ln -s /home/$USER/gits/ocelot/bin/otime ~/bin/otime
ln -s /home/$USER/gits/ocelot/bin/otmc ~/bin/otmc
```
- additionally you should configure `OCELOT_PATH` in "~/.ocelotrc"

## Configuration
"ocelot" has one user config-file; create it if you want to change default
behavior:

**`~/.ocelotrc` for general settings:**
See "config/.ocelotrc" for help adjusting the variables.

**Security updates with `oupdates.service`**
If you use systemd you can check for security-updates every time the computer resumes from sleep (hibernate); see "config/systemd/system/oupdates.service". Currently only Gentoo GLSA is supported. Syncing the portage-tree has to be done seperately.

**Lock screen with `olock.service`**
Use "config/systemd/user/olock.service" to lock your screen before your computer goes to sleep (standby).

### side-panel TODOs
Things to come (order is priority):
- disk- and swap-usage (ram, swap, `/` and `/home` as graphs; additional status(?) as box; below cpu-temperature-graph)
- support more than just "BAT0" from `/proc/sys`
- `thunderbird` notifications for new mail
- update-indication for `yum` if you are a CentOS-user
- CAPSLOCK-indication
- Xinerama-support

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
- natural scrolling (for synaptics and libxinput)
- disable right-click on touchpad (for synaptics and libxinput)
- load different ICC-profile from colord

**better reading with `~/.Xresources`:**
Copy paste from "tweaks/.Xresources": This will lighten font colors in the terminal and adds hinting and antialiasing to all applications.

## Keys
How to use `ocelot`? All keyboard-shortcuts can be changed in `config.h` (needs recompile and restart):

- **open terminal** SUPER+SHIFT+ENTER
- **open menu** ALT+F2, SUPER+MOUSE_RIGHT
- **switch desktop** SUPER+LEFT|RIGHT, SUPER+UP|DOWN, SUPER+1|2|3|4|5|6|7|8|9|0
- **switch desktop with windows** SUPER+SHIFT+LEFT|RIGHT, SUPER+SHIFT+UP|DOWN
- **switch to last desktop** SUPER+TAB
- **lock screen** SUPER+l
- **disable screen locker** SUPER+CTRL+l
- **enable screen locker** SUPER+SHIFT+l
- **move window** SUPER+w|a|s|d
- **resize window** SUPER+SHIFT+w|a|s|d, ALT+MOUSE_RIGHT+MOUSE_MOVE
- **choose as new primary window** SUPER+ENTER
- **resize primary window** SUPER+u|i
- **resize first secondary window** SUPER+o|p
- **select window on current desktop** SUPER+j|k, ALT+TAB (last), MOUSE_RIGHT
- **move window on current desktop** SUPER+SHIFT+j|k, SUPER+MOUSE_LEFT+MOUSE_MOVE
- **move selected window to another desktop** SUPER+SHIFT+1|2|3|4|5|6|7|8|9
- **change window-mode** SUPER+SHIFT+f|t|b|g|m
- **close window** SUPER+SHIFT+s
- **change display brightness** XF86MonBrightnessUp|XF86MonBrightnessDown (FN-Keys)
- **change speaker volume** (FN-Keys)
- **quit ocelot** SUPER+SHIFT+r|q

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

## ASCII-Logo
```
   ^   ^
 +-------+
 |  o_O  |
 |  >.<  |__/
 +-------+
```
