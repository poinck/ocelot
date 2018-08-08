# Readme: ocelot
- *forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*
- *"monsterwm" is similar to [catwm](https://github.com/pyknite/catwm) and was forked from "dwm"*

**ocelot:**
"ocelot" is a minimal tiling window manager bundle forked from "monsterwm" with a customized "config.h" and a side-panel instead of a top-panel.

![ocelot](/ocelot.png)

## Dependencies
- X11-header files to compile ocelot

Following dependencies are required to get the intended look and feel:
- `ocelot-dzen` for side-panel, see [ocelot-dzen](https://gitlab.com/poinck/ocelot-dzen)
- `slock` to lock your screen (see “tweaks“ for color-customizations)
- `xsetbg` (part of xloadimage) to set a wallpaper
- `xsri` to set default background gradient
- `dmenu` to run stuff
- `urxvt` to have a terminal
- `xss-lock` and `xset` to lock screen after some idle time and on hibernate/sleep
- `xbacklight` to control backlight of your notebook screen
- `amixer` from alsa to control volume
- `xrandr` to guess display height
- `xsetroot` to set a different default xcursor

Following is *optional*:
- font recommendations: Monoid L 12px/9pt for terminal and side-panel; Gidole 11pt for everything else

Things to come (order is priority):
- take screenshot, using `scrot`

Things *NOT* to come:
- Powermanagement: please use your existing setup; ocelot should have no impact on it.
- save session and restore open application, etc: please use hibernate (suspend to disk) or standby (suspend).

## Clone, Configure and Compile
```.sh
cd /home/$USER
mkdir gits
cd gits
git clone https://gitlab.com/poinck/ocelot.git
cd ocelot
vim config.h  # look, (change) and :wq
make
```

## Local Install
- it is recommended to *NOT* install ocelot system-wide because every user might want to have their own configuration
- in the future Gentoo-users may get "savedconfig"-useflag support
```.sh
make local_install
```
- additionally you should configure `OCELOT_PATH` in "~/.ocelotrc"

## Configuration
"ocelot" has one user config-file; create it if you want to change default
behavior:

**`~/.ocelotrc` for general settings:**
See "config/.ocelotrc" for help adjusting the variables.

**Check for security updates with `oupdates`**
Currently only Gentoo GLSA is supported. Syncing the portage-tree has to be done seperately.

### side-panel TODOs
Things to come (order is priority):
- support more than just "BAT0" from `/proc/sys`, see [#14](https://gitlab.com/poinck/ocelot/issues/14)

### Start ocelot
The preferred method to start ocelot is to use "~/.xinitrc".

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
- improve keyboard rate
- set different X-cursor and size
- GDK/GTK HiDPI-scaling
- load different ICC-profile from colord
- natural scrolling (for synaptics and libxinput),
- disable right-click on touchpad (for synaptics and libxinput)

**better reading with `~/.Xresources`:**
Copy paste from "tweaks/.Xresources": This will lighten font colors in the terminal and adds hinting and antialiasing to all applications.

**adjust and preserve keyrate in `~/.bashrc`:**
use `exec startx -- -ardelay 300 -arinterval 50` to start X, see [this question at UNIX-stackexchange](http://unix.stackexchange.com/questions/85504/setting-repeat-rate-of-usb-keyboard-automatically)

**still using gtk-apps and want ocelot-colors? this is for you**
Copy "tweaks/gtk-3.0/gtk.css" to "~/.config/gtk-3.0/" or add it's content to your existing theme style-sheet.

**slock colors**
If you want a ocelot color theme for your lock screen, you can use the config from “tweaks/slock-1.4_config.h“.

## Keys
How to use `ocelot`? All keyboard-shortcuts can be changed in `config.h` (needs recompile and restart):

- **open dark terminal** SUPER+SHIFT+ENTER
- **open light terminal** SUPER+CONTROL+ENTER
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

