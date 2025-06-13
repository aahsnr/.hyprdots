# Ripgrep integration with fzf and bat preview
if command -v rg &>/dev/null; then
    # Enhanced rg search with preview
    function rgs() {
        rg --color=always --heading --line-number "$@" | fzf --ansi \
            --preview 'bat --style=numbers --color=always --line-range :500 {}' \
            --preview-window 'right:60%:wrap'
    }

    # Search for contents and open in vim
    function rge() {
        local file
        local line

        read file line <<< "$(rg --no-heading --line-number $@ | fzf --ansi -0 -1 | awk -F: '{print $1, $2}')"

        if [[ -n $file ]]; then
            ${EDITOR:-nvim} $file +$line
        fi
    }

    # Search for files
    function rgf() {
        rg --files | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
    }

    # Use rg for zsh history search
    function history-rg() {
        history 1 | rg "$@"
    }

    # Use rg with bat for code search
    function rgg() {
        rg -p "$@" | less -RFX
    }

    # Completion enhancements
    compdef _rg rg
fi

# Gentoo-specific optimizations
if [[ -f /etc/gentoo-release ]]; then
    alias rg="rg --max-depth=8" # Gentoo's deep portage tree benefits from depth limit
    alias rgs="rg --type-set 'ebuild:*.ebuild' --type-set 'gentoo:*.ebuild,*.eclass,*.eselect,*.init.d' --type gentoo"
fi

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
