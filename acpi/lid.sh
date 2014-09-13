#!/bin/bash

sudo -u octocat emacsclient --eval '(jabber-disconnect)'

if [[ -n `lsmod | grep e1000` ]]
then
	rmmod e1000e
	rmmod e1000
fi
hibernate-ram

Sleep
