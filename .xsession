#!/bin/bash
rm ${HOME}/.xsession-errors
exec > ${HOME}//.xsession-errors-`date +%d-%m-%Y-%T | tr -d '[:cntrl:]'` 2>&1

# CURRENT_WM=xmonad
CURRENT_WM=stumpwm
# CURRENT_WM=i3
# CURRENT_WM=awesome

START_TRAY=1
RUN_XXKB=1
RUN_SSHUTTLE=0
DISABLE_CAPSLOCK=1
TRAY_GRAVITY=top

# TODO: try to use OS package manager for rtags itself, and el-get only for emacs part, if possible
# TODO: automate symlinking rtags binaries
export PATH=/home/octocat/.emacs.d/el-get/rtags/src:~/bin/:$PATH

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
    trayer-srg --edge $TRAY_GRAVITY --align right --monitor primary --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 16 --transparent true --tint 0x000000 &
fi
unclutter -idle 5 &
urxvtd -q -o -f
export EDITOR=emacsclient
eval `cat ~/.fehbg` &
udisks-glue -f &
volumeicon &

rdm &

arbtt-capture &
if [[ $RUN_SSHUTTLE == 1 ]] ; then
    sshuttle -r octocat.ru 0/0 --daemon
fi

sudo -u mpd /usr/bin/mpd /etc/mpd.conf

which wmname >/dev/null 2>&1 && wmname LG3D

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

redshift -l 55.751244:37.618423 -t 5500:3700 -m randr &

# dropbox &

exec $CURRENT_WM
