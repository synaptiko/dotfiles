#!/usr/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO add .bashrc
#echo "Initializing Bash configuration"
#echo -n

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

# File guake-settings.xml can be retrieved by: ./dump-guake-settings.sh
echo "Initializing Guake configuration"
gconftool-2 --load $DIR/guake-settings.xml
echo "Guake configured"
echo

# File gnome-terminal.conf can be retrieved by: ./dump-gnome-terminal-settings.sh
echo "Initializing Gnome Terminal configuration"
dconf load /org/gnome/terminal/ < $DIR/gnome-terminal-settings.conf
echo "Gnome Terminal configured"
echo

MOC_DIR=~/.moc
if [[ ! -d $MOC_DIR || ! -f $MOC_DIR/config ]]; then
	echo "Initializing MOC configuration"
	mkdir -p $MOC_DIR/themes
	ln -s $DIR/moc/config $MOC_DIR/config
	ln -s $DIR/moc/themes/jprokop_theme $MOC_DIR/themes/jprokop_theme
	echo "MOC configured"
	echo
fi

TMUX_CONF=~/.tmux.conf
if [[ ! -f $TMUX_CONF ]]; then
	echo "Initializing Tmux configuration"
	ln -s $DIR/tmux.conf $TMUX_CONF
	echo "Tmux configured"
	echo
fi
