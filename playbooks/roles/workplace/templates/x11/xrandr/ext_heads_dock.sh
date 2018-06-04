#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/octocat/.Xauthority
# multiple invocations because the Intel graphics card can only handle two outputs at a time
xrandr -d :0.0 --output {{ xrandr_dock_left_output }} --auto --left-of {{ xrandr_internal_output }} --rotate {{ xrandr_dock_left_rotation}} --gamma 1:1:{{ xrandr_blue }} --brightness {{ xrandr_brightness }}
xrandr -d :0.0 --output {{ xrandr_dock_right_output }} --auto --right-of {{ xrandr_internal_output }} --rotate {{ xrandr_dock_right_rotation }} --gamma 1:1:{{ xrandr_blue }} --brightness {{ xrandr_brightness }}
