export LANG=C.UTF-8
export LC_CTYPE=C.UTF-8
export EDITOR=/usr/bin/nvim

# tmux 
mux() {
    if tmux has-session -t main 2>/dev/null; then
        tmux attach-session -t main
        return
    fi

    tmux new-session -d -s main -n 
    tmux send-keys -t main:1 'nvim Documents' C-m

    tmux new-window -t main -n 
    tmux send-keys -t main:2 'cd Documents' C-m
    tmux send-keys -t main:2 'clear' C-m

    tmux select-window -t main:1
    tmux attach-session -t main
}

signal() {
    cd "$HOME/Desktop"
    ./signal-desktop-beta.AppImage
}

# Prompt
PROMPT='%F{yellow}󰣇 %f $ '

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

mux

ZSH_HIGHLIGHT_STYLES[builtin]='fg=3'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=3'
ZSH_HIGHLIGHT_STYLES[function]='fg=3'
ZSH_HIGHLIGHT_STYLES[alias]='fg=3'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=7'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
