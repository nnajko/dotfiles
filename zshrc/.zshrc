# PATH
export PATH="$HOME/.config/scripts:$HOME/.dotnet/tools:$HOME/.local/bin:$PATH"

# Variables
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
export SHELL='/usr/bin/zsh'

# Starship config location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Options
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt NO_BEEP

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Completions
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# Bindings
bindkey -e
bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left
bindkey "^[[1;3C" forward-word    # Alt+Right
bindkey "^[[1;3D" backward-word   # Alt+Left
bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

# Yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# Git helpers
alias gs='git status'
alias gl='git log'
alias ls='eza -lh --group-directories-first --icons=auto'
alias rm='rm -I'

gd() { git diff "$@"; }
inv() { nvim $(fzf -m --preview="bat --color=always {}"); }

# Plugins
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf
command -v fzf &>/dev/null && source <(fzf --zsh)

# Init mise
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Init zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Init starship
command -v starship &>/dev/null && eval "$(starship init zsh)"
