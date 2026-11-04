#!/bin/bash
sel=$(fd --hidden --follow \
        --exclude .git --exclude node_modules --exclude __pycache__ \
        --exclude .cache --exclude .venv --exclude target \
        --exclude .cargo --exclude .rustup --exclude .npm \
        --exclude .mozilla --exclude .var \
        --exclude .local/share/Trash --exclude .local/share/flatpak \
        . "$HOME" 2>/dev/null \
      | sed "s|^$HOME/|~/|" \
      | fuzzel --dmenu  --prompt " " --placeholder="Search files" --hide-before-typing --lines 10 --width 60) || exit 0

[ -z "$sel" ] && exit 0
xdg-open "${sel/#\~/$HOME}"