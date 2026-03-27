# Variables
export EDITOR='nvim'

# Starship config location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Options
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt AUTO_CD
setopt NO_BEEP

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# Completions
autoload -Uz compinit && compinit

# Bindings
bindkey -e
bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left
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

gd() { git diff "$@"; }
inv() { nvim $(fzf -m --preview="bat --color=always {}"); }

# Plugins
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf
command -v fzf &>/dev/null && source <(fzf --zsh)

# Init starship
command -v starship &>/dev/null && eval "$(starship init zsh)"
