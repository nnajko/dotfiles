#!/bin/bash
# Run a command in a floating terminal (class com.ghostty.float, see hyprland.lua).
# Uses ghostty, or kitty on machines where ghostty isn't supported.

if command -v ghostty > /dev/null; then
    exec ghostty --class=com.ghostty.float -e "$@"
fi
exec kitty --class=com.ghostty.float "$@"
