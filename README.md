# Dotfiles (WSL)

My WSL dotfiles managed with symlinks.

## Contents

- **nvim** - Neovim config (lazy.nvim, C#/.NET focused)
- **bat** - Bat syntax highlighter (Catppuccin theme)
- **delta** - Git delta diff viewer (Catppuccin theme)
- **git** - Git global ignore
- **starship** - Starship prompt (Catppuccin Mocha)
- **yazi** - Yazi file manager
- **zshrc** - Zsh configuration

## Setup

Symlink each config to its target location:

```sh
# Example for nvim:
ln -sf ~/dotfiles/nvim/.config/nvim ~/.config/nvim

# Or use GNU Stow:
cd ~/dotfiles
stow nvim bat delta git starship yazi
ln -sf ~/dotfiles/zshrc/.zshrc ~/.zshrc
```
