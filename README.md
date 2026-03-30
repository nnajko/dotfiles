# Dotfiles (Windows)

My Windows dotfiles managed with symlinks.

## Contents

- **nvim** - Neovim config (lazy.nvim, C#/.NET focused)
- **bat** - Bat syntax highlighter (Catppuccin theme)
- **delta** - Git delta diff viewer (Catppuccin theme)
- **git** - Git config & global ignore
- **starship** - Starship prompt (Catppuccin Mocha)
- **ssh** - SSH config
- **yazi** - Yazi file manager

## Setup

Run symlinks from an elevated PowerShell (Admin):

```powershell
# Neovim
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$HOME\dotfiles\nvim\.config\nvim"

# Git
Copy-Item "$HOME\dotfiles\git\.gitconfig" "$HOME\.gitconfig"

# Delta themes
New-Item -ItemType Junction -Path "$HOME\.config\delta" -Target "$HOME\dotfiles\delta\.config\delta"

# Bat
New-Item -ItemType Junction -Path "$env:APPDATA\bat" -Target "$HOME\dotfiles\bat\.config\bat"

# Starship
New-Item -ItemType Junction -Path "$HOME\.config\starship" -Target "$HOME\dotfiles\starship\.config\starship"

# Yazi
New-Item -ItemType Junction -Path "$env:APPDATA\yazi\config" -Target "$HOME\dotfiles\yazi\.config\yazi"

# SSH
Copy-Item "$HOME\dotfiles\ssh\.ssh\config" "$HOME\.ssh\config"
```

## Prerequisites

Install via winget or scoop:
- neovim, git, bat, delta, starship, yazi, fzf, ripgrep, fd
