#!/bin/bash
# Borg backup restore helper

BORG_REPO="/mnt/nasse/arch-files/backups/borg"
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

usage() {
    echo -e "${BOLD}Borg Restore Helper${RESET}\n"
    echo "Usage: $(basename "$0") <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list                     List all backups"
    echo "  browse <archive>         List files in a backup"
    echo "  restore-file <archive> <path>  Restore a file from backup"
    echo "  restore-all <archive>    Full restore to /mnt/restore (use from live USB)"
    echo ""
    echo -e "${DIM}Use 'list' first to find the archive name${RESET}"
}

case "${1:-}" in
    list)
        echo -e "${BOLD}Available backups:${RESET}"
        borg list "$BORG_REPO"
        ;;
    browse)
        if [ -z "${2:-}" ]; then
            echo "Usage: $(basename "$0") browse <archive>"
            echo "Run '$(basename "$0") list' to see available archives"
            exit 1
        fi
        echo -e "${BOLD}Files in $2:${RESET}"
        echo -e "${DIM}(Tip: pipe to grep to find files, e.g. $(basename "$0") browse <archive> | grep myfile)${RESET}"
        borg list "$BORG_REPO::$2"
        ;;
    restore-file)
        if [ -z "${2:-}" ] || [ -z "${3:-}" ]; then
            echo "Usage: $(basename "$0") restore-file <archive> <path>"
            echo "Example: $(basename "$0") restore-file fractal-2026-03-26_02:00 etc/fstab"
            echo ""
            echo -e "${DIM}Note: paths are relative (no leading /)${RESET}"
            exit 1
        fi
        echo -e "${BOLD}Restoring $3 from $2${RESET}"
        read -p "Restore to current directory or original location? [c/O] " choice
        if [[ "$choice" =~ ^[Cc]$ ]]; then
            borg extract "$BORG_REPO::$2" "$3"
            echo "Restored to ./$(dirname "$3")"
        else
            read -p "This will overwrite /$3. Proceed? [y/N] " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                cd /
                sudo borg extract "$BORG_REPO::$2" "$3"
                echo "Restored to /$3"
            else
                echo "Cancelled."
            fi
        fi
        ;;
    restore-all)
        if [ -z "${2:-}" ]; then
            echo "Usage: $(basename "$0") restore-all <archive>"
            echo "This is for disaster recovery from a live USB."
            exit 1
        fi
        echo -e "${BOLD}Full restore from $2${RESET}"
        echo "This will extract everything to /mnt/restore."
        echo "Make sure your btrfs volume is mounted there first."
        read -p "Proceed? [y/N] " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            sudo mkdir -p /mnt/restore
            cd /mnt/restore
            sudo borg extract "$BORG_REPO::$2"
            echo "Restore complete at /mnt/restore"
        else
            echo "Cancelled."
        fi
        ;;
    *)
        usage
        ;;
esac
