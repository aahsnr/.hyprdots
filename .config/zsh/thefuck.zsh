# Enhanced thefuck integration with Catppuccin Mocha colors
eval $(thefuck --alias --enable-experimental-instant-mode)

# Custom fuck widget for Zsh with instant mode
fuck-widget() {
    local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=False TF_CMD=$(fc -ln -1 | tail -n 1) thefuck $(fc -ln -1 | tail -n 1) 2>/dev/null)"
    [[ -n $FUCK ]] && BUFFER=$FUCK
    zle end-of-line
}
zle -N fuck-widget
bindkey '^[f' fuck-widget

# Syntax highlighting for thefuck commands
ZSH_HIGHLIGHT_STYLES[thefuck]='fg=#cba6f7,bold'

if command -v thefuck >/dev/null; then
    (nohup thefuck --load-rules >/dev/null 2>&1 &)
fi
