#---------------------------------------------
# Interactive shell
#---------------------------------------------

autoload -U colors && colors
zmodload zsh/complist

# Pimp my prompt
LPROMPT() {
PS1="%{$fg_bold[green]%}%~%{$reset_color%} \
%{$fg_bold[blue]%}>%{$reset_color%} "
}

LPROMPT


# Completion dumps
fpath=($XDG_CONFIG_HOME/zsh $fpath)
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zcompdump


zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle :compinstall filename '$ZDOTDIR/.zshrc'


# History options
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=1000000
export SAVEHIST=$((HISTSIZE/2))
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt INTERACTIVE_COMMENTS

#setopt EXTENDED_HISTORY
#setopt HIST_NO_FUNCTIONS


# Edit history
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


setopt autocd extendedglob nomatch completealiases
setopt correct          # try to correct spelling
setopt no_correctall    # ..only for commands, not filenames


# Fix for cursor position
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end


# Prevent protected characters
zle -A kill-whole-line vi-kill-line
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char


# Keybinds
bindkey -v
KEYTIMEOUT=1

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "\ep" insert-last-word
bindkey "\eq" quote-line
bindkey "\ek" backward-kill-line

# Use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Manual pages for current command
bindkey "^[h" run-help


# Colour coreutils
export GREP_COLOR="1;31"
alias grep="grep --color=auto"
alias ls="ls --color=auto"
# colours for ls
if [[ -f $XDG_CONFIG_HOME/misc/dir_colors ]]; then
    eval $(dircolors -b $XDG_CONFIG_HOME/misc/dir_colors)
fi


######## Aliases ########

# General ------------------
alias dush="du -sm *|sort -n|tail"
alias dmesg="export PAGER=/usr/bin/more; dmesg -H"
alias mutt="mutt -F $XDG_CONFIG_HOME/mutt/muttrc"


# To run bash functions
autoload bashcompinit
bashcompinit


# Source highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Supply the interactive shell functions
_functionLoadR() {
    for zZz in $1/*.zsh
    do
        source "$zZz"
    done
    unset zZz
;}

_functionLoadR "${ZDOTDIR}/functions"

unset -f _functionLoadR
