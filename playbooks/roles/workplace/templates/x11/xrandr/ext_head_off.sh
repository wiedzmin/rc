#!/bin/sh

xrandr --output {{ xrandr_vga_output }} --off # --gamma 1:1:{{ xrandr_blue }} --brightness {{ xrandr_brightness }}
