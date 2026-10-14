#! /usr/bin/bash

chosen=$(printf "Shutdown\nReboot\nLock\nToggle Mullvad" | rofi -dmenu -i)

case $chosen in
"Shutdown") poweroff ;;
"Reboot") reboot ;;
"Lock") hyprlock &>/dev/null ;;
"Toggle Mullvad")
    if systemctl is-active --quiet mullvad-daemon.service; then
        pkill -f mullvad-vpn
        systemctl stop mullvad-daemon.service
    else
        systemctl start mullvad-daemon.service
        mullvad-vpn &>/dev/null &
    fi
    ;;
esac
