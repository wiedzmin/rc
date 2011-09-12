#!/bin/bash
xrdb -merge .Xresources
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 12 --transparent true --tint 0x000000 &
# manage xscreensaver, kill gnome-screensaver, in case we use Gnome-based distribution (like Ubuntu)
killall gnome-screensaver
xscreensaver -no-splash &
# gnome-settings-daemon
xmodmap /home/ronin/xmodmaprc
export EDITOR=emacsclient
# xrandr --output VGA2 --left-of DVI0 --mode 1280x1024
eval `cat ~/.fehbg` &
xmonad
# stumpwm
