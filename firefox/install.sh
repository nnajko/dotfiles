#!/bin/bash
# Firefox user.js can't be stowed directly because profile dirs have random names.
# This script symlinks user.js into the default-release profile.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -name '*.default-release' -print -quit)

if [ -z "$PROFILE_DIR" ]; then
    echo "No default-release Firefox profile found."
    exit 1
fi

for name in user.js chrome; do
    target="$PROFILE_DIR/$name"
    # ln -sfn onto a real directory would create the link *inside* it
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mv "$target" "$target.bak-$(date +%Y%m%d-%H%M%S)"
        echo "Moved existing $name aside"
    fi
    ln -sfn "$SCRIPT_DIR/$name" "$target"
    echo "Linked $name -> $target"
done
