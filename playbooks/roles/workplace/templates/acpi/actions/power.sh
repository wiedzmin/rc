#!/bin/bash

COMMAND="echo -n standby >| /sys/power/state"  #standby
#COMMAND="echo -n disk >| /sys/power/state"    #suspend to disk
#COMMAND="/etc/init.d/shutdown.sh"             #shutdown

if [ ! -f /tmp/was_sleeping ]

	then
		touch /tmp/was_sleeping
		logger "ACPI: Going to sleep..."
		exec $COMMAND
	else
	        rm -f /tmp/was_sleeping
	        logger "ACPI: Was on S1 state, not going to sleep mode"
fi
