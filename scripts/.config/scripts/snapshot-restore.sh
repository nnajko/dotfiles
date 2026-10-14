#!/bin/bash
# Snapper snapshot helper

BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

usage() {
    echo -e "${BOLD}Snapper Snapshot Helper${RESET}\n"
    echo "Usage: $(basename "$0") <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list                     List all snapshots"
    echo "  diff <number>            Show what changed since snapshot"
    echo "  restore-file <number> <path>  Restore a file from snapshot"
    echo "  rollback <number>        Undo all changes since snapshot"
    echo ""
    echo -e "${DIM}Config is auto-detected from path (root=/, home=/home)${RESET}"
}

detect_config() {
    local path="$1"
    if [[ "$path" == /home/* ]]; then
        echo "home"
    else
        echo "root"
    fi
}

case "${1:-}" in
    list)
        echo -e "${BOLD}Root snapshots:${RESET}"
        sudo snapper -c root list
        echo ""
        echo -e "${BOLD}Home snapshots:${RESET}"
        sudo snapper -c home list
        ;;
    diff)
        if [ -z "${2:-}" ]; then
            echo "Usage: $(basename "$0") diff <snapshot-number> [root|home]"
            exit 1
        fi
        config="${3:-root}"
        echo -e "${BOLD}Changes since snapshot #$2 ($config):${RESET}"
        sudo snapper -c "$config" diff "$2..0"
        ;;
    restore-file)
        if [ -z "${2:-}" ] || [ -z "${3:-}" ]; then
            echo "Usage: $(basename "$0") restore-file <snapshot-number> <path>"
            echo "Example: $(basename "$0") restore-file 3 /etc/fstab"
            exit 1
        fi
        config=$(detect_config "$3")
        if [ "$config" = "home" ]; then
            snap_path="/home/.snapshots/$2/snapshot${3#/home}"
        else
            snap_path="/.snapshots/$2/snapshot$3"
        fi
        if [ ! -f "$snap_path" ]; then
            echo "File not found in snapshot: $snap_path"
            exit 1
        fi
        echo -e "${BOLD}Restoring $3 from snapshot #$2 ($config)${RESET}"
        echo -e "${DIM}Source: $snap_path${RESET}"
        read -p "Proceed? [y/N] " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            sudo cp "$snap_path" "$3"
            echo "Restored."
        else
            echo "Cancelled."
        fi
        ;;
    rollback)
        if [ -z "${2:-}" ]; then
            echo "Usage: $(basename "$0") rollback <snapshot-number> [root|home]"
            exit 1
        fi
        config="${3:-root}"
        echo -e "${BOLD}Rolling back $config to snapshot #$2${RESET}"
        echo "This will undo ALL changes since snapshot #$2."
        read -p "Are you sure? [y/N] " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            sudo snapper -c "$config" undochange "$2..0"
            echo "Rolled back."
        else
            echo "Cancelled."
        fi
        ;;
    *)
        usage
        ;;
esac
