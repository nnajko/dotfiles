#!/bin/bash

PROFILE_FILE="$HOME/.cache/power-profile"
CURRENT=$(cat "$PROFILE_FILE" 2>/dev/null || echo "powersave")

toggle() {
    case "$CURRENT" in
        powersave)   NEXT="balanced" ;;
        balanced)    NEXT="performance" ;;
        performance) NEXT="powersave" ;;
        *)           NEXT="powersave" ;;
    esac

    case "$NEXT" in
        powersave)
            echo balance_power | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference > /dev/null
            echo 1500 | sudo tee /proc/sys/vm/dirty_writeback_centisecs > /dev/null
            ;;
        balanced)
            echo balance_performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference > /dev/null
            echo 500 | sudo tee /proc/sys/vm/dirty_writeback_centisecs > /dev/null
            ;;
        performance)
            echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference > /dev/null
            echo 500 | sudo tee /proc/sys/vm/dirty_writeback_centisecs > /dev/null
            ;;
    esac

    echo "$NEXT" > "$PROFILE_FILE"
    pkill -RTMIN+10 waybar
}

status() {
    case "$CURRENT" in
        powersave)   ICON="󰌪"; CLASS="powersave" ;;
        balanced)    ICON="󱈏"; CLASS="balanced" ;;
        performance) ICON="󱐋"; CLASS="performance" ;;
        *)           ICON="󰌪"; CLASS="powersave" ;;
    esac
    echo "{\"text\": \"$ICON\", \"class\": \"$CLASS\", \"tooltip\": \"Power: $CURRENT\"}"
}

case "$1" in
    toggle) toggle ;;
    *)      status ;;
esac
