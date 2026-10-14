#!/bin/bash
# Borg backup to NAS
# Backs up / and /home, excluding unnecessary paths

if [ "$(id -u)" -ne 0 ]; then
    echo "Must be run as root" >&2
    exit 1
fi

export BORG_REPO="/mnt/nasse/arch-files/backups/borg"

STATUS_FILE="/home/niklasblomqvist/.cache/borg-backup-status"

# Wait up to 60s for the NAS to be reachable (covers wake-from-sleep races
# where the timer fires before WiFi reconnects).
for _ in {1..12}; do
    if ls /mnt/nasse/arch-files/backups >/dev/null 2>&1 \
       && findmnt -t nfs4 /mnt/nasse/arch-files >/dev/null; then
        break
    fi
    sleep 5
done

# Verify the real NFS mount, not just the autofs trigger.
if ! findmnt -t nfs4 /mnt/nasse/arch-files >/dev/null; then
    echo "NAS not mounted, aborting" >&2
    echo "fail $(date +%s)" > "$STATUS_FILE"
    exit 1
fi

# Create repo if not initialized
if [ ! -f "$BORG_REPO/config" ]; then
    borg init --encryption=none "$BORG_REPO"
fi

HOSTNAME=$(cat /etc/hostname)

echo "running $(date +%s)" > "$STATUS_FILE"

borg create \
    --verbose \
    --stats \
    --compression zstd,3 \
    "$BORG_REPO::${HOSTNAME}-{now:%Y-%m-%d_%H:%M}" \
    / \
    /home \
    --exclude '/dev/*' \
    --exclude '/proc/*' \
    --exclude '/sys/*' \
    --exclude '/tmp/*' \
    --exclude '/run/*' \
    --exclude '/mnt/*' \
    --exclude '/media/*' \
    --exclude '/lost+found' \
    --exclude '/var/cache/*' \
    --exclude '/var/tmp/*' \
    --exclude '/var/lib/docker/*' \
    --exclude '/var/lib/containerd/*' \
    --exclude '/var/lib/machines/*' \
    --exclude '/home/*/.cache/*' \
    --exclude '/home/*/.local/share/Trash/*' \
    --exclude '/home/*/.containers/*' \
    --exclude '/home/*/dev/**/.containers/*' \
    --exclude '/home/*/dev/**/.db-data/*' \
    --exclude '/home/*/dev/**/.pgadmin-data/*' \
    --exclude '/.snapshots/*' \
    --exclude '/home/.snapshots/*' \
    --exclude '/opt/containerd/*' \
    --exclude '/swapfile'

# Prune old backups: keep 7 daily, 4 weekly, 3 monthly
borg prune \
    --verbose \
    --list \
    "$BORG_REPO" \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=3

borg compact "$BORG_REPO"

rc=$?
if [ "$rc" -eq 0 ]; then
    echo "ok $(date +%s)" > "$STATUS_FILE"
    exit 0
else
    echo "fail $(date +%s)" > "$STATUS_FILE"
    exit "$rc"
fi
