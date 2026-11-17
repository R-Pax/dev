export LANG=C.UTF-8
export LC_CTYPE=C.UTF-8
export EDITOR=/usr/bin/nvim

# tmux 
mux() {
    [[ -n "$TMUX" ]] && return

    local session="kitty-$$"

    tmux new-session -d -s "$session" -n ""
    tmux send-keys -t "$session:1" 'nvim Documents' C-m

    exec tmux attach-session -t "$session"
}

signal() {
    cd "$HOME/Desktop"
    ./signal-desktop-beta.AppImage
}

# Prompt
PROMPT='%F{yellow} %f $ '

# Git status rightprompt

autoload -Uz vcs_info

precmd_vcs_info() {
    vcs_info

    if [[ -n "$vcs_info_msg_0_" ]]; then 
        RPROMPT="%F{yellow} ${vcs_info_msg_0_}%f"
    else
        RPROMPT=""
    fi
}

precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git:*' formats '%b'
setopt prompt_subst

mux

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[builtin]='fg=3'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=3'
ZSH_HIGHLIGHT_STYLES[function]='fg=3'
ZSH_HIGHLIGHT_STYLES[alias]='fg=3'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=7'
