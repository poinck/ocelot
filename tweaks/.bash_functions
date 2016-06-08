# HOWTO: copy this file in your home-directory if you want the same shell
# prompt as shown in in the screenshot "../ocelot.png"
#
#   ^   ^
# +-------+
# |  o_O  |
# |  >.<  |__/
# +-------+

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
BOLD='\e[1m'
RESCOL='\e[0m'
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
GRAY='\e[0;37m'
LIGHT_GRAY='\e[1;3;30m'
GRAY_BG='\e[1;7;37m'
DARK_GRAY='\e[0;37m'
DARK_GRAY_BG='\e[1;7;30m'
LIGHT_BLUE='\e[1;34m'
LIGHT_GREEN='\e[1;32m'
LIGHT_CYAN='\e[1;3;36m'
LIGHT_RED='\e[1;31m'
LIGHT_RED_BG='\e[1;7;37m'
LIGHT_PURPLE='\e[1;35m'
YELLOW='\e[0;33m'
YELLOWBOLD='\e[1;33m'
WHITE='\e[1;37m'
ROOT='\e[1;3;33m'

function git-prompt() {
    branch="$(git branch 2>/dev/null|grep '*'|awk '{ print $2 }')"
    #branch="${branch^^*}"
    [[ ! -z "$branch" ]] && echo -e "${DARK_GRAY_BG}GIT${GRAY} ${branch}${RESCOL}"
}

function parse-dirty {
  GIT_THEME_PROMPT_DIRTY="${RED}*${RESCOL}"
  GIT_THEME_PROMPT_UNTRACKED="${YELLOW}*${RESCOL}"
  if [ $(git status 2>/dev/null|grep -c 'untracked files present') -ne 0 ]; then
      echo -e "$GIT_THEME_PROMPT_UNTRACKED"
  elif [[ -n $(git status -s 2> /dev/null |grep -v ^# | grep -v "working directory clean" ) ]]; then
      echo -e "$GIT_THEME_PROMPT_DIRTY"
  else
    echo -e "$GIT_THEME_PROMPT_CLEAN"
  fi
}

function pwd1 {
	echo -en "$(pwd)"
}

function exit_code {
	local e=$(echo "$?")
	if [[ "$e" -gt 0 ]] ; then
		echo -en "${LIGHT_RED_BG}$e${RESCOL} "
	fi
}

function uptime_days {
	local procuptime=$(</proc/uptime)
	local laufzeit="${procuptime%%.*}"
	local tage=$(( laufzeit/60/60/24 ))
	echo -en "${YELLOW}t=${RESCOL}${tage}d"
}

function load1 {
	local procloadavg=$(</proc/loadavg)
	local avg1="${procloadavg%%.*}"

	# debug
	#cat /proc/loadavg
	#echo "avg1 = $avg1"

	if [[ "$avg1" -ge 1 ]] ; then
		echo -en "${GREEN}l=${RESCOL}$avg1 "
	elif [[ "$avg1" -ge 3 ]] ; then
		echo -en "${YELLOW}l=${RESCOL}$avg1 "
	elif [[ "$avg1" -eq 5 ]] ; then
		echo -en "${RED}l=${RESCOL}$avg1 "
	fi
}

function user1 {
	if [[ "${USER}" == "root" ]] ; then
		echo -en "${LIGHT_RED}"
	fi
	echo -en "${USER}" | cut -b 1
}

function prompt1 {
	if [[ "${USER}" == "root" ]] ; then
		echo -en "${LIGHT_PURPLE}"
	fi
}

get_hostname() {
    local hostname="${HOSTNAME}"
    hostname="${hostname^^*}"
    echo -en "$hostname"
}

PS1="\[\$(exit_code)\]${LIGHT_GRAY}\[$(get_hostname)\]${RESCOL} \[\$(pwd1)\] \[\$(git-prompt)\]\n\[${LIGHT_CYAN}\]\[\$(prompt1)\]\u: \[${RESCOL}\]"

