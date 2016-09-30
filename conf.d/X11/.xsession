#!/bin/bash

# CURRENT_WM=xmonad
CURRENT_WM=stumpwm
# CURRENT_WM=i3
# CURRENT_WM=awesome

START_TRAY=1
START_DROPBOX=0
START_XXKB=1
START_KBDD=0
START_TRAYER_SRG=1
START_SSHUTTLE=0
DISABLE_CAPSLOCK=1
LOGS_TO_KEEP=3

fg-run() {
    which "$1" > /dev/null && "$@"
}

bg-run() {
    full_command=$@
    base_command=${full_command%% *}
    var_name=START_${base_command^^}
    norm_var_name=${var_name//[-]/_}
    if [ -v $norm_var_name ]; then
        eval var_value=\$${norm_var_name}
        if [ $var_value -eq 1 ]; then
            echo "Starting '$full_command'";
            fg-run $full_command &
        else
            echo "'$full_command' is disabled, skipping...";
        fi
    else
        echo "Respective $norm_var_name is not set for '$full_command', running unconditionally..."
        fg-run $full_command &
    fi
}

setup-agents() {
    which ssh-agent > /dev/null && ssh_agent_binary=1
    which gpg-agent > /dev/null && gpg_agent_binary=1
    which keychain > /dev/null && keychain_binary=1

    if [[ $keychain_binary -gt 0 ]]; then
        keychain_agents=ssh
        if [[ $gpg_agent_binary -gt 0 ]]; then
            keychain_agents="$keychain_agents,gpg"
        fi
        eval "$(keychain --eval --agents "$keychain_agents" --quiet)"
    else
        if [[ $ssh_agent_binary -gt 0 ]]; then
            eval "$(ssh-agent)"
        fi
        if [[ $gpg_agent_binary -gt 0 ]]; then
            eval "$(gpg-agent --daemon)"
        fi
    fi
}

start-programs() {
    bg-run trayer-srg --edge top --align right --monitor primary --SetDockType true --SetPartialStrut true --expand true --widthtype request --height 15 --transparent true --tint 0x000000
    bg-run xxkb
    bg-run kbdd
    bg-run sshuttle -r octocat.ru 0/0 --daemon

    bg-run udisks-glue -f
    bg-run volumeicon
    bg-run rdm
    bg-run unclutter -idle 5
    bg-run arbtt-capture

    bg-run dbus-launch nm-applet

    bg-run redshift -l 55.751244:37.618423 -t 5500:3700 -m randr
    bg-run autocutsel -buttonup
    bg-run dropbox
    bg-run pulseaudio --start
}

wm-loop() {
    while true; do
        $CURRENT_WM
    done
}

rotate-xsession-errors() {
    rm "${HOME}/.xsession-errors"

    ls -a ~ | grep xsession-errors | sort -n -r | (i=0; while read -r f; do
      if [ $i -lt $((LOGS_TO_KEEP-1)) ]; then
          ((i++))
          continue
      else
          rm -f "$f"
      fi
    done)

    exec > ${HOME}//.xsession-errors-`date +%Y-%m-%d-%T | tr -d '[:cntrl:]'` 2>&1
}

process-conditionals() {
    if [ -f .Xresources ]
    then
        xrdb -merge .Xresources
    fi

    # input
    if [ -f "$HOME/xmodmaprc" ]
    then
        xmodmap "$HOME/xmodmaprc"
    fi

    if [[ $DISABLE_CAPSLOCK == 1 ]] ; then
        xmodmap -e "clear Lock"
    fi

    if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval "$(dbus-launch --sh-syntax --exit-with-session)"
    fi
}

export TZ="Europe/Moscow"
which wmname > /dev/null 2>&1 && wmname LG3D
source ~/common_settings

rotate-xsession-errors
process-conditionals
start-services
setup-agents
start-programs
wm-loop
