#!/bin/sh
xrandr --output {{ xrandr_vga_output }} --auto --right-of {{ xrandr_internal_output }}
if [ "$1" == "rotate" ]; then
    xrandr --output {{ xrandr_vga_output }} --rotate {{ xrandr_vga_rotation }} 
else 
    xrandr --output {{ xrandr_vga_output }} --rotate normal
fi
