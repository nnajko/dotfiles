# Init hyprland on login via uwsm
if uwsm check may-start 2>/dev/null; then
  exec uwsm start hyprland.desktop
fi
