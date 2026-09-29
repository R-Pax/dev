export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH" export PATH="/opt/homebrew/opt/arm-none-eabi-binutils/bin:$PATH"

# Python alias
alias py="python3"

# Pad bottom of the terminal window
precmd() {
  print -n "\n\n\n\n\n\n\n\n"
  print -n "\e[8A"
}

# tmux
mux() {
    [[ -n "$TMUX" ]] && return

    local session="ghostty-$$"

    tmux new-session -d -s "$session" -n ""
    tmux send-keys -t "$session:1" 'nvim Documents' C-m

    tmux new-window -t "$session" -n ""
    tmux send-keys -t "$session:2" 'cd Documents' C-m
    tmux send-keys -t "$session:2" 'clear' C-m

    tmux select-window -t "$session:1"
    exec tmux attach-session -t "$session"
}

# Prompt
PROMPT='%F{yellow}%f '

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

# terminal colors

source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

typeset -A ZSH_HIGHLIGHT_STYLES

# Recognized commands color 3 (#af865a)
ZSH_HIGHLIGHT_STYLES[command]='fg=3'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=3'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=3'
ZSH_HIGHLIGHT_STYLES[function]='fg=3'
ZSH_HIGHLIGHT_STYLES[alias]='fg=3'

# Unknown commands color 7 (#c0b18b) 
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=7'
