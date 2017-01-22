#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

XINITRC_FILE=~/.xinitrc
if [ ! -e $XINITRC_FILE ]; then
	echo "Initializing Xinit configuration"
	ln -s $DIR/xinitrc $XINITRC_FILE
	echo "Xinit configured"
	echo
else
	echo "Xinit configuration already exists"
	echo "If you really want to link it re/move original $XINITRC_FILE"
	echo
fi

BASH_PROFILE_FILE=~/.bash_profile
if [ ! -e $BASH_PROFILE_FILE ]; then
	echo "Initializing Bash profile configuration"
	ln -s $DIR/bash_profile $BASH_PROFILE_FILE
	echo "Bash profile configured"
	echo
else
	echo "Bash profile configuration already exists"
	echo "If you really want to link it re/move original $BASH_PROFILE_FILE"
	echo
fi

BASHRC_FILE=~/.bashrc
if [ ! -e $BASHRC_FILE ]; then
	echo "Initializing Bash configuration"
	ln -s $DIR/bashrc $BASHRC_FILE
	echo "Bash configured"
	echo
else
	echo "Bash configuration already exists"
	echo "If you really want to link it re/move original $BASHRC_FILE"
	echo
fi

BASHRC_MODULES_DIR=~/.bashrc_modules
if [ ! -d $BASHRC_MODULES_DIR ]; then
	mkdir -p $BASHRC_MODULES_DIR
	echo "You can also put another modules into $BASHRC_MODULES_DIR"
	echo
fi

# TODO solve root's .bashrc & modules more elegantly
ROOT_BASHRC_FILE=/root/.bashrc
if sudo ls $ROOT_BASHRC_FILE >& /dev/null; then
	echo "Bash configuration for root already exists"
	echo "If you really want to link it re/move original $ROOT_BASHRC_FILE"
	echo
else
	echo "Initializing Bash configuration for root"
	sudo ln -s $DIR/bashrc $ROOT_BASHRC_FILE
	echo "Bash for root configured"
	echo
fi

ROOT_BASHRC_MODULES_DIR=/root/.bashrc_modules
if sudo ls $ROOT_BASHRC_MODULES_DIR >& /dev/null; then
	echo > /dev/null # just NOP-like hack :-)
else
	sudo mkdir -p $ROOT_BASHRC_MODULES_DIR
	echo "You can also put another modules into $ROOT_BASHRC_MODULES_DIR"
	echo
fi

# TODO How to say NVIM running under root user to take config from my main user?
NVIM_DIR=~/.config/nvim
if [ ! -d $NVIM_DIR ]; then
	echo "Initializing Neovim configuration"
	mkdir -p $NVIM_DIR/{autoload,plugged}
	curl -sfLo $NVIM_DIR/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s $DIR/config/nvim/init.vim $NVIM_DIR/init.vim
	pip install --user neovim
	echo "Neovim configured"
	echo "Run \"nvim -c PlugInstall\" to install all plugins; warnings at the start can be ignored"
	echo
fi

FONTS_DIR=~/.local/share/fonts
FANTASQUE_DIR=$FONTS_DIR/FantasqueSansMono
if [[ ! -d $FONTS_DIR || ! -f $FONTS_DIR/FantasqueSansMono-Regular.otf ]]; then
	echo "Initializing fonts"
	mkdir -p $FONTS_DIR
	curl -sfLo $FONTS_DIR/FantasqueSansMono.zip \
		https://github.com/belluzj/fantasque-sans/releases/download/v1.7.0/FantasqueSansMono.zip
	mkdir $FANTASQUE_DIRFONTS_DIR
	unzip - $FONTS_DIR/FantasqueSansMono.zip -d $FANTASQUE_DIR
	mv $FANTASQUE_DIR/OTF/*.otf $FONTS_DIR
	rm -r $FANTASQUE_DIR
	rm $FONTS_DIR/FantasqueSansMono.zip
	fc-cache -f $FONTS_DIR
	echo "Font Fantasque Sans Mono installed"
	echo
fi

$XFCE4_TERMINAL_FILE=~/.config/xfce4/terminal/terminalrc
if [ ! -e $XFCE4_TERMINAL_FILE ]; then
	echo "Initializing Xfce4 Terminal configuration"
	ln -s $XFCE4_TERMINAL_FILE $DIR/config/xfce4/terminal/terminalrc-dark
	echo "Xfce4 Terminal configured"
	echo
else
	echo "Xfce4 Terminal configuration already exists"
	echo "If you really want to link it re/move original $XFCE4_TERMINAL_FILE"
	echo
fi

if pacman -Qs moc >& /dev/null; then
	MOC_DIR=~/.moc
	if [[ ! -d $MOC_DIR || ! -f $MOC_DIR/config ]]; then
		echo "Initializing MOC configuration"
		mkdir -p $MOC_DIR/themes
		ln -s $DIR/moc/config $MOC_DIR/config
		ln -s $DIR/moc/themes/jprokop_theme $MOC_DIR/themes/jprokop_theme
		echo "MOC configured"
		echo
	fi
else
	echo "MOC is not installed; ignoring its configuration"
	echo
fi

if pacman -Qs tmux >& /dev/null; then
	TMUX_CONF=~/.tmux.conf
	if [[ ! -f $TMUX_CONF ]]; then
		echo "Initializing Tmux configuration"
		ln -s $DIR/tmux.conf $TMUX_CONF
		echo "Tmux configured"
		echo
	fi
else
	echo "Tmux is not installed; ignoring its configuration"
	echo
fi

AVATAR_FILE=~/.face
if [[ ! -f $AVATAR_FILE ]]; then
	echo "Downloading avatar from Gravatar.com"
	EMAIL_HASH=$(echo -n jiri-prokop@synaptiko.cz | md5sum - | cut -d " " -f 1)
	wget --quiet -O jprokop.png http://www.gravatar.com/avatar/${EMAIL_HASH}.png?size=160
	sudo mv jprokop.png $AVATAR_FILE
	echo "Avatar installed"
	echo
fi
