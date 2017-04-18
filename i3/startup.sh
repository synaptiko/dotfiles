#!/usr/bin/env bash
# TODO add these deps to README.md!

CUSTOM_I3_DIR=$HOME/.files/i3
HOSTNAME=`hostname`

if [ -f $CUSTOM_I3_DIR/$HOSTNAME/screenlayout.sh ]; then
	$CUSTOM_I3_DIR/$HOSTNAME/screenlayout.sh
fi

xset b off
compton -b --config $CUSTOM_I3_DIR/compton.config
nitrogen --restore
redshift >& /dev/null &

if pacman -Qs deja-dup >& /dev/null; then
	/usr/lib/deja-dup/deja-dup/deja-dup-monitor >& /dev/null &
fi