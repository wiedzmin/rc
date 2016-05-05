#!/bin/bash

# CURRENT_WM=xmonad
CURRENT_WM=stumpwm
# CURRENT_WM=i3
# CURRENT_WM=awesome

START_TRAY=1
RUN_XXKB=1
RUN_SSHUTTLE=0
DISABLE_CAPSLOCK=1
TRAY_GRAVITY=top
LOGS_TO_KEEP=3

rm ${HOME}/.xsession-errors

ls -a ~ | grep xsession-errors | sort -n -r | (i=0; while read f; do
  if [ $i -lt $((LOGS_TO_KEEP-1)) ]; then
    ((i++))
    continue
  else
    rm -f "$f"
  fi
done)

exec > ${HOME}//.xsession-errors-`date +%Y-%m-%d-%T | tr -d '[:cntrl:]'` 2>&1

source ~/set_path_global

export TZ="Europe/Moscow"

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
    xmodmap -e "clear Lock"
fi

if [[ $RUN_XXKB == 1 ]] ; then
    xxkb &
else
    kbdd
fi

# service progs
if [[ $START_TRAY == 1 ]] ; then
    trayer-srg --edge $TRAY_GRAVITY --align right --monitor primary --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 15 --transparent true --tint 0x000000 &
fi

urxvtd -q -o -f
export EDITOR=emacsclient
eval `cat ~/.fehbg` &

which udisks-glue > /dev/null && udisks-glue -f &
which volumeicon > /dev/null && volumeicon &
which rdm > /dev/null && rdm &
which unclutter > /dev/null && unclutter -idle 5 &
which arbtt-capture > /dev/null && arbtt-capture &

if [[ $RUN_SSHUTTLE == 1 ]] ; then
    sshuttle -r octocat.ru 0/0 --daemon
fi

/usr/bin/pulseaudio --start

which wmname > /dev/null 2>&1 && wmname LG3D

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

eval $(ssh-agent)

which redshift > /dev/null && redshift -l 55.751244:37.618423 -t 5500:3700 -m randr &
which copyq > /dev/null && copyq &
which autocutsel > /dev/null && autocutsel -buttonup &
which dropbox > /dev/null && dropbox &

dbus-launch nm-applet &

# statusbar.sh 1 &

exec $CURRENT_WM
