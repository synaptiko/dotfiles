# Environment
export BROWSER=/usr/bin/xdg-open
export EDITOR=nvim
export VISUAL=nvim

# NVIM_TUI_ENABLE_TRUE_COLOR is problematic in Gnome Terminal: when :term is called inside Neovim colors are incorrect
# But it can be resolved in init.vim like this: https://github.com/neovim/neovim/issues/4436
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--height=100% --reverse --inline-info'

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$((HISTSIZE/2))
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# Don't beep
unsetopt beep
if [ -n "$DISPLAY" ]; then
	xset b off
fi

# Use vi-like keys
bindkey -v

# Defaults for completion
zstyle :compinstall filename '/home/jprokop/.zshrc'
zstyle ':completion:*' rehash true
autoload -Uz compinit
compinit

# Use zplug as plugin manager!
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug 'plugins/vi-mode', from:oh-my-zsh
zplug 'plugins/sudo', from:oh-my-zsh
if [ -d ~/.files ]; then
	zplug '~/.files', from:local, use:'zsh/*.zsh'
else
	zplug 'synaptiko/dotfiles', use:'zsh/*.zsh'
fi

if [ -e ~/work/aliases.zsh ]; then
	zplug '~/work', from:local
fi

# zplug 'halfo/lambda-mod', as:theme
zplug 'synaptiko/spaceship-zsh-theme', as:theme

# Spaceship theme configuration
SPACESHIP_PROMPT_SYMBOL='λ'
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_TRUNC=0
SPACESHIP_PREFIX_SHOW=true
SPACESHIP_PREFIX_HOST='@'
SPACESHIP_PREFIX_DIR=' in '
SPACESHIP_PREFIX_GIT='  '
SPACESHIP_PREFIX_ENV_DEFAULT=' via '
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_UNCOMMITTED='+'
SPACESHIP_GIT_UNSTAGED='!'
SPACESHIP_GIT_UNTRACKED='?'
SPACESHIP_GIT_STASHED='$'
SPACESHIP_GIT_UNPULLED='↓'
SPACESHIP_GIT_UNPUSHED='↑'
SPACESHIP_VI_MODE_SHOW=false

# if ! zplug check --verbose; then
# 	printf "Install? [y/N]: "
# 	if read -q; then
# 		echo; zplug install
# 	fi
# fi

zplug load

# FZF sourcing
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
