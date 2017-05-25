#---------------------------------------------
# Login shell acting as display manager
#---------------------------------------------

if [[ -z "$DISPLAY" ]] && [[ $(tty) == /dev/tty1 ]]
then
    xauth -qf "$HOME/.cache/.Xauthority" add ':0' . `mcookie`
    exec xinit xmonad -- :0 -auth "$HOME/.cache/.Xauthority" -nolisten tcp vt1
fi
