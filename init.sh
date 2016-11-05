#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# File gnome-terminal.conf can be retrieved by: ./dump-gnome-terminal-settings.sh
echo "Initializing Gnome Terminal configuration"
dconf load /org/gnome/terminal/ < $DIR/gnome-terminal-settings.conf
$DIR/switch-gnome-terminal-theme.sh dark
echo "Gnome Terminal configured"
echo

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

# Fallback for LightDM because .face file works great in `lightdm --test-mode` but not when it's really running :-(
AVATAR_FALLBACK_FILE=/var/lib/AccountsService/icons/jprokop.png
ACCOUNT_PROFILE_FILE=/var/lib/AccountsService/users/jprokop
if [[ ! -f $AVATAR_FALLBACK_FILE ]]; then
	sudo mv $AVATAR_FILE $AVATAR_FALLBACK_FILE
	sudo echo "Icon=$AVATAR_FALLBACK_FILE" >> $ACCOUNT_PROFILE_FILE
	echo "Avatar fallback installed"
	echo "But check that $ACCOUNT_PROFILE_FILE has correct content!"
	echo
fi
