#!/usr/bin/env bash
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
numlockx &
xbanish &
exec i3
