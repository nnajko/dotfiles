#!/bin/bash
# Firefox user.js can't be stowed directly because profile dirs have random names.
# This script symlinks user.js into the default-release profile.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -name '*.default-release' -print -quit)

if [ -z "$PROFILE_DIR" ]; then
    echo "No default-release Firefox profile found."
    exit 1
fi

ln -sf "$SCRIPT_DIR/user.js" "$PROFILE_DIR/user.js"
echo "Linked user.js -> $PROFILE_DIR/user.js"

ln -sfn "$SCRIPT_DIR/chrome" "$PROFILE_DIR/chrome"
echo "Linked chrome/ -> $PROFILE_DIR/chrome"
