# HINT: do not replace your "~/.bashrc" with this file, just copy what you need
#
#   ^   ^
# +-------+
# |  o_O  |
# |  >.<  |__/
# +-------+

# load a prompt that fits to "ocelot"
if [[ -f ~/.bash_functions ]] ; then
	. ~/.bash_functions
	export PS1
fi

# autostart X after login and takeover process of shell
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
    exec startx
fi

