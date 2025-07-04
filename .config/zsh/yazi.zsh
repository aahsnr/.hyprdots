# Yazi aliases for quick access
alias yy='yazi'
alias yz='yazi $(pwd)'

# Yazi with directory tracking (recommended)
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Yazi completion
if command -v yazi &> /dev/null; then
    source <(yazi --generate-completion zsh)
fi

# Yazi configuration
export YAZI_FILE_ONE="bat --paging=never --color=always"
export YAZI_CONFIG_HOME="$HOME/.config/yazi"

