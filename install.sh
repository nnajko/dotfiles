#!/usr/bin/env bash
# Symlink the dotfiles into $HOME with GNU Stow.
#
#   ./install.sh              every package
#   ./install.sh --cli        terminal packages only (no Hyprland desktop)
#   ./install.sh nvim tmux    just these packages
#
# Existing files that would block a link are moved to ~/.dotfiles-backup/<timestamp>/.
# Safe to re-run.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

CLI=(bat delta git mise nvim scripts ssh starship tmux yazi zshrc)
DESKTOP=(autostart backgrounds cliphist ghostty gtk hypr kitty rofi satty swaync swayosd uwsm waybar)

case "${1:-}" in
	"") packages=("${CLI[@]}" "${DESKTOP[@]}") ;;
	--cli) packages=("${CLI[@]}") ;;
	-h | --help)
		sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'
		exit 0
		;;
	*) packages=("$@") ;;
esac

command -v stow >/dev/null || { echo "stow is not installed: sudo pacman -S stow" >&2; exit 1; }

for pkg in "${packages[@]}"; do
	[ -d "$DOTFILES/$pkg" ] || { echo "No such package: $pkg" >&2; exit 1; }
done

has() {
	local p
	for p in "${packages[@]}"; do [ "$p" = "$1" ] && return 0; done
	return 1
}

# These must be real directories. If they don't exist, stow would symlink the
# whole directory into the repo, and e.g. new SSH keys would end up in git.
mkdir -p "$HOME/.config" "$HOME/.config/autostart" "$HOME/.icons/default" "$HOME/.local/bin"
mkdir -p -m 700 "$HOME/.ssh"

moved=0
backup() {
	local rel=$1
	moved=1
	mkdir -p "$BACKUP/$(dirname "$rel")"
	mv "$HOME/$rel" "$BACKUP/$rel"
	echo "  moved ~/$rel -> $BACKUP/$rel"
}

# Hyprland writes a default hyprland.conf on first launch, and it would win
# over our hyprland.lua.
if has hypr && [ -f "$HOME/.config/hypr/hyprland.conf" ] && [ ! -L "$HOME/.config/hypr" ]; then
	backup .config/hypr/hyprland.conf
fi

echo "Checking for conflicts..."
for pkg in "${packages[@]}"; do
	while IFS= read -r -d '' src; do
		rel=${src#"$DOTFILES/$pkg/"}
		target="$HOME/$rel"
		if [ -e "$target" ] || [ -L "$target" ]; then
			[ "$(realpath -m "$target")" = "$(realpath -m "$src")" ] && continue
			backup "$rel"
		fi
	done < <(find "$DOTFILES/$pkg" -path '*/.git' -prune -o \( -type f -o -type l \) -print0)
done

# An emptied app dir (e.g. ~/.config/hypr) would stop stow from linking the
# directory itself, and new files there would then live outside the repo.
for pkg in "${packages[@]}"; do
	for app in "$DOTFILES/$pkg"/.config/*/; do
		[ -d "$app" ] || continue
		dir="$HOME/.config/$(basename "$app")"
		[ -d "$dir" ] && [ ! -L "$dir" ] && rmdir "$dir" 2>/dev/null || true
	done
done

echo "Stowing: ${packages[*]}"
stow --restow --dir "$DOTFILES" --target "$HOME" "${packages[@]}"

# Post-link setup
if has bat && command -v bat >/dev/null; then
	bat cache --build >/dev/null && echo "Rebuilt bat theme cache"
fi

if has satty; then
	mkdir -p "$HOME/Pictures/Screenshots"
fi

if has uwsm && command -v systemctl >/dev/null; then
	# PAM must be the only thing starting gnome-keyring, or the login keyring stays locked
	systemctl --user mask gnome-keyring-daemon.socket gnome-keyring-daemon.service 2>/dev/null || true
	systemctl --user enable gcr-ssh-agent.socket hyprpolkitagent.service 2>/dev/null || true
	echo "Configured systemd user units (keyring, ssh-agent, polkit)"
fi

if has hypr; then
	if find "$HOME/.mozilla/firefox" -maxdepth 1 -name '*.default-release' 2>/dev/null | grep -q .; then
		"$DOTFILES/firefox/install.sh"
	else
		echo "Firefox profile not found: start Firefox once, then run firefox/install.sh"
	fi
fi

[ "$moved" = 1 ] && echo "Replaced files are in $BACKUP"
echo "Done. See README.md for the one-time manual steps."
