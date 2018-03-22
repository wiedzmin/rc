#!/bin/sh
xrandr --output {{ xrandr_vga_output }} --auto --right-of {{ xrandr_internal_output }} --gamma 1:1:{{ xrandr_blue }} --brightness {{ xrandr_brightness }}
if [ "$1" == "rotate" ]; then
    xrandr --output {{ xrandr_vga_output }} --rotate {{ xrandr_vga_rotation }} 
else 
    xrandr --output {{ xrandr_vga_output }} --rotate normal
fi
