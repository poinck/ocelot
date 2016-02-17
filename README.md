# Readme: ocelot
- *forked from [monsterwm](https://github.com/c00kiemon5ter/monsterwm)*
- *I have found out that "monsterwm" is similar to [catwm](https://github.com/pyknite/catwm), it is a catmonster!*

**ocelot:**
"ocelot" is a minimal tiling window manager bundle forked from "monsterwm" with
not yet added functions, but a predefined "config.h" besides the original template
"config.def.h" and some scripts and resources to feel at home right from the start.

![ocelot](/ocelot.png)

## Dependencies

- `xsetbg` (part of xloadimage) to set a wallpaper
- `dzen2` for ocelotbar
- `dmenu` to run stuff
- `urxvt` to have a terminal
- `i3lock` to lock your screen
- `xautolock` to lock screen after some idle time (10 minutes)
- *optional* `tmd` to show local temperature, see [tm](https://github.com/poinck/tm)

Things to come (order is priority):
- LCD-brightness control for Thinkpads through `/sys`
- side-panel, see "./idea" and [THIS](https://poinck.de/screenFetch-2016-02-16_22-45-33.png) awesome screenshot
- speaker-volume control (this will be tricky, I suppose)
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
First make sure ocelots bin-folder is in your `$PATH` or symlinked in a folder
in your `$PATH`. Second compile `ocelot` if you happy with your changes in "config.h":
```.sh
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
- display brightness indication
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
- **seelct window** ALT+j|k
- **change tiling-mode** ALT+SHIFT+f|t|b|g|m

## FAQ

**Will `ocelot` run with wayland?**
If all dependencies and `monsterwm` will support libwayland then I can maybe adjust the instructions to install and setup `ocelot`. Currently I do not plan to port it to libwayland. If you can do it, that'll be great! *(:*

## License
Licensed under MIT/X Consortium License, see [LICENSE][law] file for more
copyright and license information.
- Changes I made after the fork are licensed under CC0 if the MIT-license
permits it

  [law]: https://raw.github.com/c00kiemon5ter/monsterwm/master/LICENSE

## Thanks
- [monsterwm](https://github.com/c00kiemon5ter/monsterwm)


