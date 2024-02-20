#!/usr/bin/bash

if [ "$#" -eq 0 ]; then
	echo "USAGE: confqtile FILENAME"
	exit 1
fi

if [ "$1" = 'default' ]; then
	flnm="/home/$USER/.config/qtile.default.backup"
else
	flnm="./$1"
fi

if [ ! -f "$flnm/config.py" ]; then
	echo "ERROR: No 'config.py' file in directory"
	exit 1
fi

rsync -av --delete "$flnm/" "/home/$USER/.config/qtile/"

# qtile start -b wayland
