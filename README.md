# Dotfiles (Arch Linux / Hyprland)

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stow Packages

| Package | Description |
|---------|-------------|
| `backgrounds` | Desktop wallpapers |
| `bat` | Syntax highlighting (Catppuccin Mocha) |
| `delta` | Git diff viewer themes |
| `ghostty` | Terminal emulator config |
| `git` | Git config with delta pager |
| `hypr` | Hyprland, hypridle, hyprlock, hyprpaper, hyprsunset |
| `nvim` | Neovim (lazy.nvim, blink.cmp, treesitter, telescope) |
| `rofi` | Application launcher |
| `starship` | Shell prompt (Catppuccin Mocha) |
| `swaync` | Notification daemon |
| `tmux` | Terminal multiplexer (Catppuccin, vim-tmux-navigator) |
| `waybar` | Status bar |
| `yazi` | File manager (Catppuccin Mocha) |
| `zshrc` | Zsh config (mise, zoxide, fzf, starship) |

## Setup

```bash
# Clone
git clone https://github.com/nnajko/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Terminal tools
stow bat delta git nvim starship tmux yazi zshrc

# Desktop (Hyprland)
stow backgrounds ghostty hypr rofi swaync waybar

# Install tmux plugins (inside tmux)
# prefix + I
```

## Prerequisites

`bat` `delta` `eza` `fzf` `ghostty` `hyprland` `mise` `neovim` `rofi` `starship` `tmux` `waybar` `yazi` `zoxide` `zsh`
