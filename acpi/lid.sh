#!/bin/bash


#!/bin/sh
# check if the lid is open or closed, using the /proc file
if grep closed /proc/acpi/button/lid/LID/state >/dev/null ; then
    # if the lid is now closed, save the network state and suspend to RAM
    sudo -u octocat emacsclient --eval '(jabber-disconnect)'
    /usr/share/wicd/daemon/suspend.py
    hibernate-ram
else
    # if the lid is now open, restore the network state.
    # (if we are running, a wakeup has already occured!)
    /usr/share/wicd/daemon/autoconnect.py
fi

Sleep
