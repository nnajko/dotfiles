#!/bin/bash
# Reload config and style in place; start waybar if it isn't running
pkill -USR2 -x waybar || uwsm app -- waybar &
