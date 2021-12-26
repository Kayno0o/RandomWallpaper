#!/bin/bash

if [ $1 != "-h" ] && [ $1 != "--help" ]; then
    IMAGES_FOLDER="~/Pictures"
    for i in $(seq 1 $#)
    do
        if [ "${!i}" = "-d" ]; then
            j=$((i+1))
            IMAGES_FOLDER="${!j}"
        fi
    done

    NITROGEN="false"
    for param in "$@"
    do
        if [ "$param" = "-n" ]; then
            NITROGEN="true"
        fi
    done

    SAVE_FOLDER="~/.config"
    for i in $(seq 1 $#)
    do
        if [ "${!i}" = "-o" ]; then
            j=$((i+1))
            SAVE_FOLDER="${!j}"
        fi
    done

    echo "  Loading random wallpaper from $IMAGES_FOLDER..."
    WALLPAPER=$(find $IMAGES_FOLDER -type f | shuf -n 1)
    if [ NITROGEN == "true" ]; then
        sed -i 's@file=.*@file='$WALLPAPER'@' ~/.config/nitrogen/bg-saved.cfg
    fi

    echo "  Loading and generating color scheme..."

    if [ NITROGEN == "true" ]; then
        nitrogen --restore 2> /dev/null
        wal -i $WALLPAPER -n 2> /dev/null
    else
        wal -i $WALLPAPER 2> /dev/null
    fi

    echo "  Saving to $SAVE_FOLDER"

    echo "
    BACKGROUND_COLOR=$(sed -n '1p' ~/.cache/wal/colors)
    TEXT_COLOR=$(sed -n '3p' ~/.cache/wal/colors)
    GOOD_COLOR=$(sed -n '8p' ~/.cache/wal/colors)
    WARNING_COLOR=$(sed -n '2p' ~/.cache/wal/colors)
    ERROR_COLOR=$(sed -n '6p' ~/.cache/wal/colors)
    FOCUS=$(sed -n '5p' ~/.cache/wal/colors)
    " > "$SAVE_FOLDER/color_scheme"

    echo "  Done"
else
    echo "
    Usage:
        random_wallpaper.sh [DIRECTORY] [OPTIONS]

    Options:
        -d DIRECTORY
            Path to a directory with images.
        -n  Use Nitrogen
        -o  Save color scheme to another file
    "
fi