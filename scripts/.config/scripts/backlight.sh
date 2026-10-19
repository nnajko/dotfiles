#!/bin/bash
# Waybar module: screen brightness. Prints nothing on machines without a
# backlight, which hides the module (the built-in one shows 0% instead).

for dev in /sys/class/backlight/*; do
    [ -e "$dev" ] || exit 0
    break
done

pct=$(( $(cat "$dev/brightness") * 100 / $(cat "$dev/max_brightness") ))
icons=(󰃞 󰃟 󰃠)
icon=${icons[$(( pct * 3 / 101 ))]}
echo "{\"text\": \"$icon $pct%\", \"tooltip\": \"Brightness: $pct%\"}"
