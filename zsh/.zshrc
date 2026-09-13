export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH"
export PATH="/opt/homebrew/opt/arm-none-eabi-binutils/bin:$PATH"

# Pad bottom of the terminal window
precmd() {
  print -n "\n\n\n\n\n\n\n\n"
  print -n "\e[8A"
}

# tmux 
alias mux='tmux new-session -A -s main'

# Prompt
PROMPT='%n@  %1~ %# '

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
