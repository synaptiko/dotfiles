#!/usr/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dconf dump /org/gnome/terminal/ > $DIR/gnome-terminal-settings.conf
