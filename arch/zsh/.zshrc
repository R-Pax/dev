eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# tmux 
mux() {
    if tmux has-session -t main 2>/dev/null; then
        tmux attach-session -t main
        return
    fi

    tmux new-session -d -s main -n nvim
    tmux send-keys -t main:1 'nvim Documents' C-m

    tmux new-window -t main -n git
    tmux send-keys -t main:2 'cd Documents' C-m
    tmux send-keys -t main:2 'clear' C-m

    tmux new-window -t main -n zsh

    tmux select-window -t main:1
    tmux attach-session -t main
}

# Prompt
PROMPT='%n@ 󰣇 %1~ %# '

# Git status rightprompt

autoload -Uz vcs_info

precmd_vcs_info() {
    vcs_info

    if [[ -n "$vcs_info_msg_0_" ]]; then 
        RPROMPT=" ${vcs_info_msg_0_}"
    else
        RPROMPT=""
    fi
}

precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git:*' formats '%b'
setopt prompt_subst

