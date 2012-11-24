#!/bin/bash
if [ -f .Xresources ]
then
    xrdb -merge .Xresources
fi

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 12 --transparent true --tint 0x000000 &
xscreensaver -no-splash &
unclutter -idle 5 &

if [ -f $HOME/xmodmaprc ]
then
    xmodmap $HOME/xmodmaprc
fi

export EDITOR=emacsclient

eval `cat ~/.fehbg` &

# xcompmgr &
# arbtt-capture &

xxkb &
dropbox &
xmonad

# stumpwm
