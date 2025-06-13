#!/usr/bin/zsh
# Enhanced man page support for Zsh
export MANPAGER="less -R --use-color -Dd+r -Du+b -Dk+Y -DM +Gg"

# Colored man pages with Catppuccin-compatible colors
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\033[38;2;243;139;168m") \   # Red
    LESS_TERMCAP_md=$(printf "\033[38;2;137;180;250m") \    # Blue
    LESS_TERMCAP_me=$(printf "\033[0m") \
    LESS_TERMCAP_se=$(printf "\033[0m") \
    LESS_TERMCAP_so=$(printf "\033[48;2;89;89;115m\033[38;2;249;226;175m") \ # Yellow on surface2
    LESS_TERMCAP_ue=$(printf "\033[0m") \
    LESS_TERMCAP_us=$(printf "\033[38;2;166;227;161m") \    # Green
    man "$@"
}

# Fuzzy man page search
fzman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}
zle -N fzman
bindkey '^X^M' fzman

# Man page completion
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select
