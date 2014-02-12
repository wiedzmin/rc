#!/bin/bash
if [ -f .Xresources ]
then
    xrdb -merge .Xresources
fi

# input
if [ -f $HOME/xmodmaprc ]
then
    xmodmap $HOME/xmodmaprc
fi
xmodmap -e "remove lock = Caps_Lock"
xinput set-button-map `xinput --list | grep Synaptics | awk '{i=NF-3; print $i}' | awk 'BEGIN { FS = "=" } ; { print $2 }'` 1 2 3 5 4 7 6 9 8 10 11 12
xxkb &

# service progs
trayer-srg --edge top --align right --monitor primary --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 16 --transparent true --tint 0x000000 &
unclutter -idle 5 &
urxvtd -q -o -f
export EDITOR=emacsclient
eval `cat ~/.fehbg` &
udisks-glue -f &
# arbtt-capture &
# parcellite -d

# compositing
# xcompmgr &
# compton -cGb

# WM
# xmonad
exec /home/octocat/.commonlisp/stumpwm.bin
