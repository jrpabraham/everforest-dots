#!/bin/bash
sel=$(fd --hidden --follow \
        --exclude .git --exclude node_modules --exclude .cache \
        . "$HOME" 2>/dev/null \
      | sed "s|^$HOME/|~/|" \
      | rofi -dmenu -i -matching fuzzy -sort -sorting-method fzf -p "open") || exit 0

[ -z "$sel" ] && exit 0
setsid xdg-open "${sel/#\~/$HOME}" >/dev/null 2>&1 &