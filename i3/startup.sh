#!/usr/bin/env bash
# TODO add these deps to README.md!
CUSTOM_I3_DIR=$HOME/.files/i3

compton -b --config $CUSTOM_I3_DIR/compton.config
nitrogen --restore
redshift >& /dev/null &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 >& /dev/null &

if pacman -Qs deja-dup >& /dev/null; then
	/usr/lib/deja-dup/deja-dup/deja-dup-monitor >& /dev/null &
fi
