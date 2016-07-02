#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -h'
alias ll='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hl'
alias la='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlA'
alias lt='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlt'
alias ltag='ls -t | ag'
alias grep='grep --color=tty -d skip'
alias df='df -h'
#alias up='sudo pacman -Syu'
alias up='sudo systemctl start reflector && sudo pacman -Syu' # TODO prepare better update script! also it should be probably in its own module

# git
alias gs='git status'
alias gl='git log'
alias ga='git add'
alias gr='git rm'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git grep --break --heading --line-number'
alias gcm='git commit'
alias gpl='git pull --rebase'
alias gps='git push'
alias gsth='git stash'
alias gstp='git stash pop'
alias gfp='git fetch --prune'
alias gcho='git checkout'
alias gchrp='git cherry-pick -x'

if [ "$USER" == "root" ]; then
	PS1='\[\e[0;31m\]\u\[\e[m\]@\h \[\e[0;34m\]\w\[\e[m\] \[\e[0;31m\]\$\[\e[m\] '
else
	PS1='\[\e[0;32m\]\u\[\e[m\]@\h \[\e[0;34m\]\w\[\e[m\] \[\e[0;32m\]\$\[\e[m\] '
fi
BROWSER=/usr/bin/xdg-open

export EDITOR=nvim
export VISUAL=nvim

# See https://github.com/jamessan/vim-gnupg/blob/master/plugin/gnupg.vim#L32
GPG_TTY=`tty`
export GPG_TTY

# NVIM_TUI_ENABLE_TRUE_COLOR is problematic in Gnome Terminal: when :term is called inside Neovim colors are incorrect
# But it can be resolved in init.vim like this: https://github.com/neovim/neovim/issues/4436
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--reverse --inline-info'

# Better history handling
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # update histfile after every command

complete -cf sudo

if ls ~/.bashrc_modules/* >& /dev/null; then
	for module in ~/.bashrc_modules/*; do
		source ${module}
	done
fi
