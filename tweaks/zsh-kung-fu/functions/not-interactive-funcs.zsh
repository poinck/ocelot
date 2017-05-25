# Is the given variable empty ?
__am_i_null() {
    if [[ -z $1 ]]
    then
        printf '%s\n' 'Houston, we have a problem'
        return 0 # __am_i_null ${var} && do_empty_thing || do_non_empty_thing
    else
        return 1
    fi
;}


# archlinux.zsh
__WriteTo() { echo -en $2 | sudo tee $1 > /dev/null ;}


# backup.zsh
__replace_folder() {
    rm --recursive --force $1
    cp --recursive $2 $1
;}


# generate random internal (local) ip
# and some fake MAC addresses
__gen_rants() {
    for x in {1..2}
    do
        gen_addr=$[RANDOM%250]
        gen_mac=$(for x in {1..6};do printf '%02x:' $[RANDOM%256];done)
        gen_mac[18]=''
    done

    dT=(
        'addr'       "${bHz}.${gen_addr}"
        'broadcast'  "${bHz}.255"
        'gateway'    "${bHz}.254"
        'fakemac'    "${gen_mac}"
    )
}


# save the tweak_peripherials.zsh conf
_save_conf() {
  local mouse=$(gawk '/(threshold:)/ {print $4}' <(xset q))
  local kb=$(gawk '/(repeat delay)/ {print $4}' <(xset q))
  printf "%s" "xset m 20/10 ${mouse} r rate ${kb} 30 b on" \
         > "$XDG_CACHE_HOME/.mouse-kb"
}


#---------------------------------------------
# Mouse Tweaking
#---------------------------------------------
_change_mouse_speed() {
  let "set_to = $(gawk '/(threshold:)/ {print $4}' <(xset q)) $1"
  let "perc   = 110 - ${set_to}"
  xset m 20/10 "${set_to}"
    # xset mouse:
    #   Acceleration 20
    #   Acceleration Denom (constant=10)
    #   Threshold - variable
  printf '%s%%\n' "Mouse sensitivity ${perc}"
    # Left-handed people:
    #   xmodmap -e "pointer = 3 2 1"
  _save_conf
}


#---------------------------------------------
# Volume Tweaking
#---------------------------------------------
_change_volume () {
  amixer --quiet sset Master $1 unmute
  local vol=$(gawk '/(%)/ {gsub(/[\[\]]/,""); print $5; exit}'\
                                     <(amixer sget Master))
  printf '%s\n' "Volume set to ${vol}"
}


#---------------------------------------------
# Keyboard Tweaking
#---------------------------------------------
_change_delay() {
  local cur_delay=$(gawk '/(repeat delay)/ {print $4}' <(xset q))
  local mouse_speed=$(gawk '/(threshold:)/ {print $4}' <(xset q))
  let "new_ms = ${cur_delay} $1"
  xset m 20/10 "${mouse_speed}" r rate "${new_ms}" 30 b on
    # xset keyboard:
    #   Defaults:
    #     [delay 500] - variable
    #     [rate 30]
    #   r rate 500 30 b on
    #   'r' controls autorepeat delay
    #   'rate' controls repeat rate
    #   'b' controls bell volume
    #   The delay is the number of milliseconds before
    #   autorepeat starts, and the rate is the number
    #   of repeats per second.
  printf '%s\n' "Keyboard repeat delay ${new_ms} ms"
  _save_conf
}

# check the last program exit code status
# and repeat it until it exits with 0
# code meaning 'success'
__loop_until_ok() { while [[ $? != 0 ]]; do $@; done ;}


# crypto-luks.zsh
# determine whether the user has supplied a
# device mapper name and assign the appropriate
# string to the variable 'dmnqme' and mount point
# My boot partition is encrypted... new kernel ...
__null_test() {
    [[ ! -z $1 ]] && dmnqme="$1" || dmnqme='root'
    [[ ${dmnqme} == 'boot' ]] && _mount_point='/boot' \
        || _mount_point='/mnt'
;}


# crypto-luks.zsh
__opencrypt_mini() {
    $@
    __loop_until_ok $@
;}


# compress.zsh
# pixz does not show any benefits
# pbzip2 is twice slower than lbzip2
__run_parallel() {
    [[ -x "$(command -v $1)" ]] && local comp_prog=$1 \
        || local comp_prog=$2

    ${comp_prog} --verbose --force -9 `basename $3.tar`
;}


# extract.zsh
# The extraction function that does
# all the heavy lifting by using steroids
# and several other prohibited substances
__fucktard() {
    [[ "$(dirname $1)" == "." ]] && local dir_name="${PWD}" \
        || local dir_name="$(dirname $1)"

    local f_name="$(basename $1)"
    local temp_one="$(mktemp --directory --tmpdir XXXXXXX)"
    local temp_two="$(mktemp --directory --tmpdir=${temp_one} XXXXXXX)"

    mv $1 "${temp_two}" && cd "${temp_two}"

    case $2 in
        bz2-orig)  bunzip2 --verbose "${f_name}"              ;;
        gz-orig)   gunzip  --verbose "${f_name}"              ;;
        xz-orig)   unxz    --verbose "${f_name}"              ;;
        zip-orig)  python2 -c"from zipfile import ZipFile;
with ZipFile('"${f_name}"', 'r') as archive:
    print('\n'.join(' \033[1;95mextracted\033[0m: \033[1;94m{0}\033[0m'.format(x.filename)\
    for x in archive.infolist()));archive.extractall()"       ;;
        seven_zip) 7z x "${f_name}"                           ;;
        rar-orig)  unrar x "${f_name}"                        ;;
        lzop-orig) lzop --verbose --extract "${f_name}"       ;;
        lrz-orig)  lrzuntar -v "${f_name}"                    ;;
        tar-orig|lz4-orig)
                if [[ "$2" == "lz4-orig"  ]]
                then
                    lz4 --verbose --decompress "${f_name}"
                    f_name="${f_name%%.lz4}"
                fi
                if [[ "${f_name}" == *.tar ]]
                then
                    tar --skip-old-files \
                        --verbose --extract --file "${f_name}"
                fi                                         ;;
           # filter the archive through program $2(--xxx)
           *) tar --skip-old-files \
                  --verbose --extract $2 --file "${f_name}"  ;;
    esac
    # The more scenarios I can think of, `mv'
    # becomes true trouble maker. Let's leave
    # python to deal most common issues (if any)
    python2 -c"import os;from shutil import move,rmtree;
whos_here=os.listdir(os.getcwd());charge=os.path.join;
is_grenate=os.path.isfile;is_dynamite=os.path.isdir;defuse=os.remove;
for x in whos_here:
    say_what=charge('"${dir_name}"',x);
    if is_grenate(say_what):  defuse(say_what);
    if is_dynamite(say_what): rmtree(say_what);
[move(x,'"$dir_name"') for x in whos_here];"
    cd "${dir_name}" && rm -rf "${temp_one}"
;}

# archlinux.zsh
__fileExists() { [[ -f $1 ]] && return 0 || return 1 ;}
