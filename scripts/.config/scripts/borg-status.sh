#!/bin/bash
# Waybar module: borg backup status

STATUS_FILE="$HOME/.cache/borg-backup-status"

if [ ! -f "$STATUS_FILE" ]; then
    # No backups on this machine: print nothing so waybar hides the module
    exit 0
fi

read -r status timestamp < "$STATUS_FILE"
now=$(date +%s)
age=$(( (now - timestamp) / 3600 ))

if [ "$status" = "running" ]; then
    echo '{"text": "󰋊 ", "class": "running", "tooltip": "Backup in progress..."}'
elif [ "$status" = "ok" ]; then
    if [ "$age" -gt 48 ]; then
        echo "{\"text\": \"󰋊 ${age}h\", \"class\": \"stale\", \"tooltip\": \"Last backup: ${age}h ago\"}"
    else
        echo "{\"text\": \"󰋊\", \"class\": \"ok\", \"tooltip\": \"Last backup: ${age}h ago\"}"
    fi
else
    echo "{\"text\": \"󰋊 !\", \"class\": \"fail\", \"tooltip\": \"Last backup failed ${age}h ago\"}"
fi
