#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please, provide a path to a directory with images."
    exit 1
fi

FOLDER=$1

echo "  Loading random wallpaper from $FOLDER..."
WALLPAPER=$(find $FOLDER -type f | shuf -n 1)
if [ $2 == "-n" ]; then
    sed -i 's@file=.*@file='$WALLPAPER'@' ~/.config/nitrogen/bg-saved.cfg
fi

echo "  Loading and generating color scheme..."

if [ $2 == "-n" ]; then
    nitrogen --restore 2> /dev/null
fi

if [ $2 == "-n" ]; then
    wal -i $WALLPAPER -n 2> /dev/null
else
    wal -i $WALLPAPER 2> /dev/null
fi

# GOOD_COLOR = 3rd line of ~/.cache/wal/colors
BACKGROUND_COLOR=$(sed -n '1p' ~/.cache/wal/colors)
TEXT_COLOR=$(sed -n '3p' ~/.cache/wal/colors)
GOOD_COLOR=$(sed -n '8p' ~/.cache/wal/colors)
WARNING_COLOR=$(sed -n '2p' ~/.cache/wal/colors)
ERROR_COLOR=$(sed -n '6p' ~/.cache/wal/colors)
FOCUS=$(sed -n '5p' ~/.cache/wal/colors)

echo "
BACKGROUND_COLOR=$BACKGROUND_COLOR
TEXT_COLOR=$TEXT_COLOR
GOOD_COLOR=$GOOD_COLOR
WARNING_COLOR=$WARNING_COLOR
ERROR_COLOR=$ERROR_COLOR
FOCUS=$FOCUS
" > color_scheme

echo "  Done"
