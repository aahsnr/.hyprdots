# FZF configuration for Gentoo with Catppuccin Mocha
export FZF_DEFAULT_OPTS="
--height 40% --layout=reverse --border
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=gutter:#1e1e2e
--preview-window=right:60%:wrap
--bind='ctrl-d:preview-page-down,ctrl-u:preview-page-up'
--bind='ctrl-y:execute-silent(echo {} | xclip -selection clipboard)'
--bind='ctrl-e:execute($EDITOR {})'
--ansi"

# Use fd (faster and respects .gitignore)
if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Gentoo-specific optimizations
export FZF_COMPLETION_DIR_COMMANDS="emerge equery ebuild"

# Enhanced file preview with syntax highlighting
export FZF_PREVIEW_COMMAND="[[ \$(file --mime {}) =~ binary ]] &&
    echo '{} is a binary file' ||
    (bat --style=numbers --color=always {} ||
    cat {}) 2>/dev/null | head -500"

# Gentoo package search integration
function fzf_gentoo_packages() {
    local selected
    selected=$(qlist -IC | fzf --multi --preview 'equery m {}' --preview-window=right:50%:wrap)
    [[ -n "$selected" ]] && echo "$selected"
}

# Portage search integration
function fzf_portage_search() {
    local query selected
    query="$1"
    selected=$(emerge --search "$query" | fzf --multi \
        --preview 'emerge -pvc {2}' \
        --preview-window=right:50%:wrap | awk '{print $2}')
    [[ -n "$selected" ]] && echo "$selected"
}

# Zsh widgets for key bindings
function fzf_gentoo_packages_widget() {
    local result=$(fzf_gentoo_packages)
    if [[ -n "$result" ]]; then
        LBUFFER+="$result "
        zle redisplay
    fi
}
zle -N fzf_gentoo_packages_widget
bindkey '^p' fzf_gentoo_packages_widget
