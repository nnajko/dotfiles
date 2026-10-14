#!/bin/sh
# Retry hyprlock up to 3 times if it crashes
pidof hyprlock && exit 0
for i in 1 2 3; do
    hyprlock && break
    sleep 0.5
done
