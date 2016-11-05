#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$1" == "light" ]]; then
	THEME_FILE=$DIR/gnome-terminal-settings-light-theme.conf
else
	THEME_FILE=$DIR/gnome-terminal-settings-dark-theme.conf
fi

cat $THEME_FILE | sed -r -e 's/\s+#.*$//' | sed -e ':a;/[,\[]$/{N;s/\n//;ba}' | head -n -1 | sed -r -e 's/^(palette.*)/\1]/' | dconf load /org/gnome/terminal/
