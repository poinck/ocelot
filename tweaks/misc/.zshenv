#---------------------------------------------
# First read configuration
#---------------------------------------------

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# setup environment
export AWKPATH="/usr/share/awk"
export AWKLIBPATH="/usr/lib/gawk"
export XINITRC="$HOME/.config/misc/xinitrc"
export GNUPGHOME="$HOME/.config/gnupg"
export GIMP2_DIRECTORY="/tmp/gimp"
export WINEPREFIX="$HOME/.config/wine"
export GCC_COLORS="always"
export XAUTHORITY="$HOME/.cache/.Xauthority"
export PYTHONSTARTUP="$HOME/.config/misc/python"
export PYTHONOPTIMIZE=3
export RXVT_SOCKET='/tmp/virus.exe'

export LC_ALL=
export LC_COLLATE="C"
export LESS="FX"
export PERL_SIGNALS="unsafe"
export EDITOR="/usr/bin/vim"
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export SDCV_PAGER="/usr/bin/less"
export SYSTEMD_PAGER="less -j4aR"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export PATH="${PATH}:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin"
export INFODIR="/usr/share/info:/usr/local/share/info"

# Use wildward to find the current gcc version
gcc_libs=$(printf '%s' /usr/lib/gcc/x86_64-pc-linux-gnu/*)
export LDPATH="/lib:/usr/lib:/usr/local/lib:${gcc_libs}"
unset gcc_libs

# Radeon video acceleration
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=r600

# man page colours
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;35m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;30;03;36m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;34m'

# setup default dirs
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
