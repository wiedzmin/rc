#!/bin/bash

logger "ACPI: Time to sleep"
touch /tmp/was_sleeping
echo -n standby > /sys/power/state
