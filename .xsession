#!/bin/bash
# CURRENT_WM=xmonad
CURRENT_WM=/home/octocat/.commonlisp/stumpwm.bin
# CURRENT_WM=i3
# CURRENT_WM=awesome

START_TRAY=0
RUN_XXKB=0
DISABLE_CAPSLOCK=0

if [ -f .Xresources ]
then
    xrdb -merge .Xresources
fi

# input
if [ -f $HOME/xmodmaprc ]
then
    xmodmap $HOME/xmodmaprc
fi

if [[ $DISABLE_CAPSLOCK == 1 ]] ; then
    xmodmap -e "remove lock = Caps_Lock"
fi

xinput set-button-map `xinput --list | grep Synaptics | awk '{i=NF-3; print $i}' | awk 'BEGIN { FS = "=" } ; { print $2 }'` 1 2 3 5 4 7 6 9 8 10 11 12
if [[ $RUN_XXKB == 1 ]] ; then
    xxkb &
else
    kbdd
fi

# service progs
if [[ $START_TRAY == 1 ]] ; then
    trayer-srg --edge top --align right --monitor primary --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 16 --transparent true --tint 0x000000 &
fi
unclutter -idle 5 &
urxvtd -q -o -f
export EDITOR=emacsclient
eval `cat ~/.fehbg` &
udisks-glue -f &

exec $CURRENT_WM
