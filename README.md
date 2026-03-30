# Dotfiles (WSL)

My WSL dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- **bat** - Bat syntax highlighter (Catppuccin theme)
- **delta** - Git delta diff viewer (Catppuccin theme)
- **git** - Git config, delta integration, global ignore
- **nvim** - Neovim config (lazy.nvim, C#/.NET focused)
- **ssh** - SSH config
- **starship** - Starship prompt (Catppuccin Mocha)
- **tmux** - Tmux config
- **yazi** - Yazi file manager
- **zshrc** - Zsh config (zoxide, fzf, mise, autosuggestions, syntax-highlighting)

## Setup

```sh
cd ~/dotfiles
stow bat delta git nvim ssh starship tmux yazi zshrc
```
