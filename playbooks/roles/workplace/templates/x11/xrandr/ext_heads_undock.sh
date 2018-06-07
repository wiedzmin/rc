#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/octocat/.Xauthority
# multiple invocations because the Intel graphics card can only handle two outputs at a time
xrandr -d :0.0 --output {{ xrandr_dock_left_output }} --off
xrandr -d :0.0 --output {{ xrandr_dock_right_output }} --off
xrandr -d :0.0 --output {{ xrandr_internal_output }} --auto --primary # --gamma 1:1:{{ xrandr_blue }} --brightness {{ xrandr_brightness }}

{% if xsession_current_wm == "stumpwm" %}
{% if x11_stumpwm_on_xrandr_commands is defined %}
{% for command in x11_stumpwm_on_xrandr_commands %}
/usr/bin/stumpish {{ command }}
{% endfor %}
{% endif %}
{% endif %}

{% if xsession_current_wm == "xmonad" %}
{% if x11_xmonad_on_xrandr_commands is defined %}
# Under construction
{% endif %}
{% endif %}

{% if xsession_current_wm == "awesome" %}
{% if x11_awesomewm_on_xrandr_commands is defined %}
{% for command_line in x11_awesomewm_on_xrandr_commands %}
echo '{{ command_line }}' | awesome-client
{% endfor %}
{% endif %}
{% endif %}
