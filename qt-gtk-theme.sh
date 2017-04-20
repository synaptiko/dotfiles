#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp $DIR/gtkrc-2.0 ~/.gtkrc-2.0
mkdir -p ~/.config/gtk-3.0
cp $DIR/config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
mkdir -p ~/.config/qt5ct
cp $DIR/config/qt5ct/qt5ct.conf ~/.config/qt5ct/qt5ct.conf

sed -E -i 's/(^font=).\+$/\1"Cantarell,11,-1,5,50,0,0,0,0,0"/' ~/.config/Trolltech.conf
sed -E -i 's/(^style=).\+$/\1Adwaita/' ~/.config/Trolltech.conf
sed -E -i 's/(^.+theme-name=).+$/\1"Adwaita"/g' ~/.gtkrc-2.0
sed -E -i 's/(^.+theme-name=).+$/\1Adwaita/g' ~/.config/gtk-3.0/settings.ini
sed -E -i 's/(^icon_theme=).+$/\1Adwaita/' ~/.config/qt5ct/qt5ct.conf
sed -E -i 's/(^style=).+$/\1Adwaita/' ~/.config/qt5ct/qt5ct.conf
