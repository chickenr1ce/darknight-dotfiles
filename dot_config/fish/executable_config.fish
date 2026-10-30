# Functions

function fish_prompt -d "Write out the prompt"
    # Note: this is overridden by `starship init` in the interactive block below.
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# wrapper for yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end


# Key bindings

function fish_user_key_bindings
    # Ctrl+Backspace arrives as ^H (ctrl-h) in this terminal, so that is the key
    # to bind. Confirm with `fish_key_reader` if the terminal changes.
    bind ctrl-h backward-kill-word
end


# Environment

# default editor
set -gx EDITOR micro
set -gx HSA_OVERRIDE_GFX_VERSION 12.0.1

# Added by Antigravity CLI installer
set -gx PATH "$HOME/.local/bin" $PATH


# Interactive-only setup

if status is-interactive # Commands to run in interactive sessions can go here

    # T3 Code's terminal can't answer fish's Primary Device Attribute query, so
    # fish waits 10 seconds before the prompt. Skip the query to avoid the stall.
    if not contains -- no-query-term $fish_features
        set -Ua fish_features no-query-term
    end

    # No greeting
    set fish_greeting

    # Prompt
    starship init fish | source
    # if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    #    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    # end

    # Set up fzf key bindings
    fzf --fish | source

    # Directory jumping
    zoxide init fish | source

end


# Aliases

alias pamcan pacman
alias ls 'eza --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias q 'qs -c ii'
alias ff 'fastfetch'

alias skinpulse 'cd /home/alexiz/Projects/CS2_SkinPrice_Scraper && python3 tui.py'
alias skinpulse-manage 'cd /home/alexiz/Projects/CS2_SkinPrice_Scraper && python3 manage.py'
alias please 'sudo'
alias updatepls 'sudo pacman -Syu'
alias winboot 'sudo efibootmgr -n 0000 && reboot'
