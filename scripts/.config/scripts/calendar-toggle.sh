#!/bin/bash
# Toggle floating calcurse window with CalDAV sync

if pgrep -x calcurse > /dev/null; then
    pkill calcurse
    calcurse-caldav &>/dev/null &
    exit 0
fi

calcurse-caldav &>/dev/null
ghostty --gtk-single-instance=false --title='calcurse-float' --window-width=150 --window-height=40 -e calcurse
