# HINT: do not replace your "~/.bashrc" with this file, just copy what you need
#
#   ^   ^
# +-------+
# |  o_O  |
# |  >.<  |__/
# +-------+

# ls alias:
# - sorted by block size (largest last)
# - no control chars
# - use escapes for quoting
alias ls='ls -srS --color=auto -q --quoting-style=escape'

# load a prompt that fits to "ocelot"
if [[ -f ~/.bash_functions ]] ; then
	. ~/.bash_functions
	export PS1
fi

# autostart X after login and takeover process of shell
if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
    exec startx
fi

