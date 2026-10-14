# Dotfiles (Arch Linux / Hyprland)

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow package that mirrors `$HOME`.

## New machine

```bash
# 1. Packages (AUR via yay or paru)
sudo pacman -S --needed git stow
git clone git@github.com:nnajko/dotfiles.git ~/dotfiles   # or https://github.com/nnajko/dotfiles.git
cd ~/dotfiles
sudo pacman -S --needed - < packages.txt
yay -S --needed - < packages-aur.txt

# 2. Link everything (existing files are moved to ~/.dotfiles-backup/<timestamp>/)
./install.sh            # everything
./install.sh --cli      # terminal tools only, no Hyprland desktop
./install.sh nvim tmux  # specific packages
```

`install.sh` is safe to re-run. Besides stowing it rebuilds the bat theme cache, creates
`~/Pictures/Screenshots`, masks the systemd gnome-keyring units, enables `gcr-ssh-agent.socket` and
`hyprpolkitagent.service`, and links the Firefox config if a profile exists.

### One-time manual steps

```bash
chsh -s /usr/bin/zsh
sudo usermod -aG video "$USER"   # brightness keys (swayosd); log out and back in
```

**Keyring unlock at login.** PAM has to be the only thing that starts gnome-keyring. In
`/etc/pam.d/login`, add each line below the existing `include` of the same type (`auth`, `session`,
`password`):

```
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
password   optional     pam_gnome_keyring.so use_authtok
```

**Hyprland plugin.** Workspaces use [split-monitor-workspaces](https://github.com/zjeffer/split-monitor-workspaces)
(4 per monitor). Until it is built, Hyprland falls back to normal workspaces 1-4. Run from a terminal
inside Hyprland (hyprpm asks for sudo):

```bash
hyprpm update
hyprpm add https://github.com/zjeffer/split-monitor-workspaces
hyprpm enable split-monitor-workspaces
```

If hyprpm fails with "failed to create cache dir", run `sudo chown -R $USER: /var/cache/hyprpm/$USER`.

**Monitors.** `hypr/.config/hypr/hyprland.lua` loads `hosts/<hostname>.lua` if it exists, otherwise
every display uses its preferred mode (fine for a laptop). To pin a layout, copy `hosts/fractal.lua`
to `hosts/$(cat /etc/hostname).lua` and edit it (`hyprctl monitors` lists the outputs).

**Firefox.** Start Firefox once so it creates a profile, then run `firefox/install.sh`.

**tmux plugins** install themselves the first time tmux starts.

**Dev tools** not covered by packages: Go tools (`go install golang.org/x/tools/gopls@latest`,
`golang.org/x/tools/cmd/goimports@latest`, `mvdan.cc/gofumpt@latest`,
`github.com/go-delve/delve/cmd/dlv@latest`) and the language toolchains in `mise/.config/mise/config.toml`
(`mise install`).

## Packages

| Package | Contents |
|---------|----------|
| `autostart` | Hides gnome-keyring XDG autostart entries (PAM starts the keyring) |
| `backgrounds` | Wallpapers |
| `bat` | Catppuccin Mocha theme |
| `cliphist` | Clipboard history |
| `delta` | Git diff themes |
| `firefox` | `user.js` and `userChrome.css`, linked by `firefox/install.sh` (not stowed) |
| `ghostty` | Terminal |
| `git` | Git config with delta pager, global ignore |
| `gtk` | GTK 3/4 colours and theme, default cursor theme |
| `hypr` | Hyprland (Lua), hypridle, hyprlock, hyprsunset, per-host monitor files |
| `mise` | Global tool versions |
| `nvim` | Neovim (lazy.nvim, blink.cmp, treesitter, telescope, dap) |
| `rofi` | Launcher |
| `satty` | Screenshot annotation |
| `scripts` | `~/.config/scripts`: waybar modules, power menu, backup/snapshot helpers (on `$PATH`) |
| `ssh` | SSH client config (keys stay out of the repo) |
| `starship` | Prompt |
| `swaync` | Notifications |
| `swayosd` | Volume/brightness OSD |
| `tmux` | tmux (Catppuccin, vim-tmux-navigator) |
| `uwsm` | Session environment for Hyprland |
| `waybar` | Status bar. The second bar only appears on the desktop's Dell monitor |
| `yazi` | File manager |
| `zshrc` | `.zshrc` and `.zprofile` (starts Hyprland via uwsm on TTY login) |

Machine-specific bits stay out of git: `nvim` lazy-lock, GTK bookmarks, `*.local` files.
