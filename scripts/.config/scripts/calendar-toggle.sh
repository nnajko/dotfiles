#!/bin/bash
# Toggle floating calcurse window with CalDAV sync

if pgrep -x calcurse > /dev/null; then
    pkill calcurse
    calcurse-caldav &>/dev/null &
    exit 0
fi

calcurse-caldav &>/dev/null
if command -v ghostty > /dev/null; then
    ghostty --gtk-single-instance=false --title='calcurse-float' --window-width=150 --window-height=40 -e calcurse
else
    kitty --title='calcurse-float' -o remember_window_size=no -o initial_window_width=150c -o initial_window_height=40c calcurse
fi
