#!/bin/bash
# Waybar power profile module.

PROFILE_FILE="$HOME/.cache/power-profile"

# CPUs without HWP (e.g. the laptop's Ivy Bridge) have no energy_performance_preference;
# switch TLP profiles through tlp-pd there instead (no sudo needed, see tlp-pd.policy).
# Otherwise set the preference directly, which needs the sudoers rule from the README.
USE_TLP=0
if [ ! -e /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference ] && command -v tlpctl > /dev/null; then
    USE_TLP=1
    case "$(tlpctl get 2>/dev/null)" in
        power-saver) CURRENT="powersave" ;;
        balanced)    CURRENT="balanced" ;;
        performance) CURRENT="performance" ;;
    esac
else
    CURRENT=$(cat "$PROFILE_FILE" 2>/dev/null || echo "powersave")
fi

apply() {
    if [ "$USE_TLP" = 1 ]; then
        local target=$1
        [ "$1" = powersave ] && target="power-saver"
        tlpctl set "$target" > /dev/null || return 1
        # The switch is applied asynchronously; wait for it so the icon is right
        for _ in 1 2 3 4 5 6 7 8 9 10; do
            [ "$(tlpctl get 2>/dev/null)" = "$target" ] && return 0
            sleep 0.2
        done
        return 1
    fi

    case "$1" in
        powersave)   epp=balance_power;       writeback=1500 ;;
        balanced)    epp=balance_performance; writeback=500 ;;
        performance) epp=performance;         writeback=500 ;;
    esac
    # -n: fail instead of waiting for a password nobody can type from waybar
    echo "$epp" | sudo -n tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference > /dev/null &&
        echo "$writeback" | sudo -n tee /proc/sys/vm/dirty_writeback_centisecs > /dev/null &&
        echo "$1" > "$PROFILE_FILE"
}

toggle() {
    local order=(powersave balanced performance powersave balanced) i
    for i in 0 1 2; do
        [ "${order[$i]}" = "$CURRENT" ] && break
    done
    # Skip a profile the machine doesn't offer
    apply "${order[$i + 1]}" 2>/dev/null || apply "${order[$i + 2]}" 2>/dev/null ||
        notify-send "Power profile" "Couldn't change profile (see ~/.config/scripts/power-profile.sh)"
    pkill -RTMIN+10 waybar
}

status() {
    case "$CURRENT" in
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
