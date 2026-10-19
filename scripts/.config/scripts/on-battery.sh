#!/bin/bash
# Exit 0 when running on battery, for hypridle's battery-only listeners
for bat in /sys/class/power_supply/BAT*; do
    [ "$(cat "$bat/status" 2>/dev/null)" = Discharging ] && exit 0
done
exit 1
