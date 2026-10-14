#!/bin/bash

PROFILE_FILE="$HOME/.cache/power-profile"
CURRENT=$(cat "$PROFILE_FILE" 2>/dev/null || echo "powersave")

# CPUs without HWP (e.g. the laptop's Ivy Bridge) have no energy_performance_preference;
# switch TLP profiles through tlp-pd there instead (no sudo needed, see tlp-pd.policy).
USE_TLP=0
if [ ! -e /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference ] && command -v tlpctl > /dev/null; then
    USE_TLP=1
    case "$(tlpctl get 2>/dev/null)" in
        power-saver) CURRENT="powersave" ;;
        balanced)    CURRENT="balanced" ;;
        performance) CURRENT="performance" ;;
    esac
fi

toggle() {
    case "$CURRENT" in
        powersave)   NEXT="balanced" ;;
        balanced)    NEXT="performance" ;;
        performance) NEXT="powersave" ;;
        *)           NEXT="powersave" ;;
    esac

    if [ "$USE_TLP" = 1 ]; then
        local target=$NEXT
        [ "$NEXT" = powersave ] && target="power-saver"
        tlpctl set "$target" > /dev/null
        # The switch is applied asynchronously; wait for it so the icon is right
        for _ in 1 2 3 4 5 6 7 8 9 10; do
            [ "$(tlpctl get 2>/dev/null)" = "$target" ] && break
            sleep 0.2
        done
        pkill -RTMIN+10 waybar
        return
    fi

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
