source /usr/share/cachyos-fish-config/cachyos-config.fish

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cat='bat'
alias cd='z'
alias decompress='tar -xzf'
alias ff='fzf --preview '\''bat --style=numbers --color=always {}'\'''
alias g='git'
alias gcad='git commit -a --amend'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias t='tmux attach || tmux new -s Work'

set -Ux EDITOR micro
set -Ux VISUAL micro

zoxide init fish | source

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

function conda
    source ~/miniconda3/etc/fish/conf.d/conda.fish
    command conda $argv
end

# Auto-start Hyprland via UWSM on login
if status is-login
    if uwsm check may-start
        exec uwsm start hyprland.desktop
    end
end
