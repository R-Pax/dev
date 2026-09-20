eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

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

