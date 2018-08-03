# HOWTO: copy this file in your home-directory if you want the same shell
# prompt as shown in the screenshot "../ocelot.png"
#
#   ^   ^
# +-------+
# |  o_O  |
# |  >.<  |__/
# +-------+

# colors
#             MR:      MB:
C0='\e[30m' # *color0, *color8,  gray/
C1='\e[31m' # *color1, *color9,  orange/ (red)
C2='\e[32m' # *color2, *color10, green/
C3='\e[33m' # *color3, *color11, yellow/
C4='\e[34m' # *color4, *color12, blue/
C5='\e[35m' # *color5, *color13, purple/
C6='\e[36m' # *color6, *color14, cyan/
C7='\e[37m' # *color7, *color15, white/

# modifiers
MR='\e[0m' # reset
MB='\e[1m' # bold (lighter)
MI='\e[3m' # italic

# monochrome kernel config
export MENUCONFIG_COLOR=mono

function get_gitprompt() {
    branch="$(git branch 2>/dev/null|grep '*'|awk '{ print $2 }')"
    [[ ! -z "$branch" ]] && echo -en "${MR}${branch}${MR}"
}

function pwd1 {
	echo -en "$(pwd)"
}

function get_exit_code {
	local e=$(echo "$?")
	if [[ "$e" -gt 0 ]] ; then
		echo -en "${MB}$e${MR} "
	fi
}

function get_time() {
    local daytime=$( date '+%-d %^b %0H %0M' )
    local formatted_dt="${MR}${MI}${MB}${C0}"

    local i=0
    for dt in $daytime ; do
        if [[ "$i" -eq 0 ]] ; then
            # day in month
            formatted_dt="${formatted_dt}${dt}"
        elif [[ "$i" -eq 1 ]] ; then
            # month
            formatted_dt="${formatted_dt}${C0}${dt:0:3}"
        elif [[ "$i" -eq 2 ]] ; then
            # hour
            formatted_dt="${formatted_dt} ${MR}${MI}${MB}${C0}${dt}"
        elif [[ "$i" -eq 3 ]] ; then
            # minute
            formatted_dt="${formatted_dt}${C0}${dt}"
        fi
        i=$(( i+1 ))
    done
    echo -en "${formatted_dt}${MR}"
}

function get_hostname() {
    local hostname="${HOSTNAME}"
    hostname="${hostname^^*}"
    #hostname="${hostname:0:1}"
    if [[ "${USER}" == "root" ]] ; then
        echo -en "${C1}"
    elif [[ "${USER}" == "steam" ]] ; then
        echo -en "${C6}"
    else
        echo -en "${C4}"
    fi
    echo -en "$hostname${MR}"
}

function get_username() {
    local username="${USER}"
    #username="${username^^*}"
    #username="${username:0:1}"
    echo -en "$username${MR}"
}

#\[\$(get_time)\]
PS1="\[\$(get_exit_code)\]${MR}${C7}$(get_hostname) \[\$(get_username)\] ${C7}\[\$(pwd1)\] \[\$(get_gitprompt)\]${MR}\n ! "

