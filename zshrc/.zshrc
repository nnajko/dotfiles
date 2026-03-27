# Init hyprland on login
if [[ "$(tty)" == "/dev/tty1" ]]; then
  exec hyprland &> /dev/null
fi

# Variables
export EDITOR='nvim'
export SHELL='/usr/bin/zsh'

# Starship config location
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Bindings
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
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

# Alias
alias gs='git status'
alias gd='git diff ${1}'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='eza -lh --group-directories-first --icons=auto'
alias gl='git log'

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# fzf
source <(fzf --zsh)

# Init starship
eval "$(starship init zsh)"
