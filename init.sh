#!/usr/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Initializing Neovim configuration"
mkdir -p ~/.config/nvim/{autoload,plugged}
curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $DIR/config/nvim/init.vim ~/.config/nvim/init.vim
echo "Run \"nvim -c PlugInstall\" to install all plugins; warnings at the start can be ignored"
