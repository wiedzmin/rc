#!/bin/bash

if [[ -n `lsmod | grep e1000` ]]
then
	rmmod e1000e
	rmmod e1000
fi
hibernate-ram

Sleep
