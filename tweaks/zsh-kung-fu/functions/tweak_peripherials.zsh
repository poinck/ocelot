# The functions below are meant to replace:
# volumeicon, lxinput, lxrandr

# Increase volume with 5%
volup()   { _change_volume 5+ ;}

# Decrease volume with 5%
voldown() { _change_volume 5- ;}

# Increase mouse sensitivity with 10%
mouseup()   { _change_mouse_speed -10 ;}

# Decrease mouse sensitivity with 10%
mousedown() { _change_mouse_speed +10 ;}

# Increase repeat delay with 100 ms
kbup()   { _change_delay +100 ;}

# Decrease repeat delay with 100 ms
kbdown() { _change_delay -100 ;}

#---------------------------------------------
# Monitor tweaking
#---------------------------------------------
res() {
  if [[ -z $1 ]] ; then
    local all_res="\033[1;93m`xrandr`"
    local cur_res="\033[1;95mCurrent resolution: \033[1;94m`\
      xrandr | gawk -F ',' 'NR==1 {gsub("( |current)","");print $2}'`"
    local gpu="\033[1;95mGPU: \033[1;94m`\
      lspci  | gawk -F '[' '/(VGA)/ {gsub("]","");OFS="";print $2,$3}'`"
    for x in "${all_res}" "${cur_res}" "${gpu}"; do
      printf '%b\n' $x
    done
    printf '%b\n' "\033[0mTo change the current resolution type:\
  \033[1;91mres\033[0m \033[1;44m1280x720"
  else
    local display_port=`gawk '/( connected)/ {print $1}' <(xrandr)`
    xrandr --verbose --output "${display_port}" --mode $1
  fi
}
