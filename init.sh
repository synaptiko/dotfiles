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
	echo "Neovim configured"
	echo "Run \"nvim -c PlugInstall\" to install all plugins; warnings at the start can be ignored"
	echo
fi

FONTS_DIR=~/.local/share/fonts
if [[ ! -d $FONTS_DIR || ! -f $FONTS_DIR/FantasqueSansMono-Regular.otf ]]; then
	echo "Initializing fonts"
	mkdir -p $FONTS_DIR
	curl -sfLo $FONTS_DIR/FantasqueSansMono.tar.gz \
		https://github.com/belluzj/fantasque-sans/releases/download/v1.7-alpha.2/FantasqueSansMono.tar.gz
	tar -xzf $FONTS_DIR/FantasqueSansMono.tar.gz -C $FONTS_DIR OTF
	mv $FONTS_DIR/OTF/*.otf $FONTS_DIR
	rmdir $FONTS_DIR/OTF
	rm $FONTS_DIR/FantasqueSansMono.tar.gz
	fc-cache -f $FONTS_DIR
	echo "Font Fantasque Sans Mono installed"
	echo
fi

GUAKE_DIR=~/.config/gconf/apps/guake
if [ ! -d $GUAKE_DIR ]; then
	# TODO could be replaced by usage of "gconftool-2 --dump /apps/guake"
	echo "Initializing Guake configuration"
	mkdir -p $GUAKE_DIR
	rmdir $GUAKE_DIR
	ln -s $DIR/config/gconf/apps/guake $GUAKE_DIR
	echo "Guake configured"
	echo
fi

# File gnome-terminal.conf can be retrieved by:
# dconf dump /org/gnome/terminal/ > ~/.files/gnome-terminal.conf
echo "Initializing Gnome Terminal configuration"
dconf load /org/gnome/terminal/ < $DIR/gnome-terminal.conf
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
