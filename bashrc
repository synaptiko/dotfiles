#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -h --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -lAh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias df='df -h'

# TODO add PS1 for root also
PS1='\[\e[0;32m\]\u\[\e[m\]@\h \[\e[0;34m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '
BROWSER=/usr/bin/xdg-open

export EDITOR=nvim

# NVIM_TUI_ENABLE_TRUE_COLOR is problematic in Gnome Terminal: when :term is called inside Neovim colors are incorrect
# if [[ $TERM == 'xterm-256color' ]]; then
#	export NVIM_TUI_ENABLE_TRUE_COLOR=1
# fi
export TERM=gnome-256color

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# clean-up recently used because I don't like it
echo -n > $HOME/.local/share/recently-used.xbel

complete -cf sudo
