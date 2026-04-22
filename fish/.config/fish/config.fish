source /usr/share/cachyos-fish-config/cachyos-config.fish

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/justin/miniconda3/bin/conda
    eval /home/justin/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/justin/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/justin/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/justin/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

