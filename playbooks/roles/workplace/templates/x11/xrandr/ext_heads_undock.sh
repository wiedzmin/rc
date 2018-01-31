#!/bin/sh

# multiple invocations because the Intel graphics card can only handle two outputs at a time
xrandr -d :0.0 --output {{ xrandr_dock_left_output }} --off
xrandr -d :0.0 --output {{ xrandr_dock_right_output }} --off
xrandr -d :0.0 --output {{ xrandr_internal_output }} --auto --primary
