#!/usr/bin/zsh
# Initialize zoxide with Catppuccin Mocha theme colors and Gentoo optimizations
if command -v zoxide >/dev/null; then
    # Use faster database backend (Gentoo-specific optimization)
    export _ZO_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zoxide"
    mkdir -p "$_ZO_DATA_DIR"

    # Initialize zoxide with optimized settings
    eval "$(zoxide init zsh --hook pwd --cmd j)"

    # Enhanced completion (Gentoo-specific paths)
    compctl -U -K _zoxide_z_cmd -x 'C[-1,-*e],C[-1,-*h]' -c - 'c[-1,-l]' -/ -- j

    # Catppuccin Mocha theme colors for zoxide prompt
    export _ZO_FG_OLD='#a6adc8'    # Subtext0 (old path color)
    export _ZO_FG_NEW='#89b4fa'    # Blue (new path color)
    export _ZO_FG_QUERY='#f5e0dc'  # Rosewater (query color)
    export _ZO_FG_ERROR='#f38ba8' # Red (error color)
    export _ZO_FG_SUCCESS='#a6e3a1' # Green (success color)

    # Custom zoxide prompt with Gentoo-inspired colors
    _zoxide_hook() {
        local ret=$?
        if [[ $ret -eq 0 ]]; then
            print -Pn "%F{$_ZO_FG_SUCCESS}✓%f "
        else
            print -Pn "%F{$_ZO_FG_ERROR}✗%f "
        fi
        print -Pn "%F{$_ZO_FG_QUERY}Gentoo%f %F{$_ZO_FG_NEW}%~%f "
    }
    add-zsh-hook precmd _zoxide_hook
fi

# ======================
# Quality of Life Improvements
# ======================

# Enhanced directory jumping with fzf integration (if available)
if command -v fzf >/dev/null; then
    function j() {
        if [[ $# -eq 0 ]]; then
            local dir
            dir=$(zoxide query -l | fzf --height 40% --reverse --tac \
                --color='bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8' \
                --color='fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc' \
                --color='marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8' \
                --preview 'exa -la --color=always --icons --group-directories-first {}') &&
            zoxide add "$dir" && builtin cd "$dir"
        else
            zoxide query --exclude "$(pwd)" "$@" | head -n 1 | while read -r dir; do
                [ -n "$dir" ] && zoxide add "$dir" && builtin cd "$dir"
            done
        fi
    }
fi

# Gentoo-specific directory shortcuts
alias jportage='j /usr/portage'
alias joverlay='j /var/db/repos'
alias jebuilds='j /var/db/pkg'
alias jmakeconf='j /etc/portage'

# ======================
# Git Optimizations
# ======================

# Faster git status for zoxide (async)
function _zoxide_git_status() {
    local git_dir
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -n "$git_dir" ]]; then
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        if [[ -n "$branch" ]]; then
            print -Pn " %F{$_ZO_FG_QUERY}%f%F{#b4befe} ${branch}%f"

            # Async git status indicators
            {
                local ahead behind staged unstaged untracked
                ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
                behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
                staged=$(git diff --cached --numstat | wc -l)
                unstaged=$(git diff --numstat | wc -l)
                untracked=$(git ls-files --others --exclude-standard | wc -l)

                [[ "$ahead" -gt 0 ]] && print -Pn " %F{$_ZO_FG_SUCCESS}↑${ahead}%f"
                [[ "$behind" -gt 0 ]] && print -Pn " %F{$_ZO_FG_ERROR}↓${behind}%f"
                [[ "$staged" -gt 0 ]] && print -Pn " %F{$_ZO_FG_SUCCESS}●${staged}%f"
                [[ "$unstaged" -gt 0 ]] && print -Pn " %F{$_ZO_FG_ERROR}✚${unstaged}%f"
                [[ "$untracked" -gt 0 ]] && print -Pn " %F{$_ZO_FG_QUERY}…${untracked}%f"
            } &!
        fi
    fi
}

# Add git status to zoxide prompt
add-zsh-hook precmd _zoxide_git_status

# ======================
# Gentoo-Specific Optimizations
# ======================

# Optimize zoxide database location for Gentoo's filesystem structure
export _ZO_EXCLUDE_DIRS='/usr/portage/distfiles/*:/var/tmp/*:/usr/src/*'

# Faster database updates (Gentoo often has many directory changes)
export _ZO_MAXAGE=5000  # Increase max age for Gentoo's frequent updates

# Pre-populate zoxide with common Gentoo directories
[ -f "${_ZO_DATA_DIR}/db.zo" ] || {
    zoxide add ~
    zoxide add /etc/portage
    zoxide add /usr/portage
    zoxide add /var/db/repos
    zoxide add /var/db/pkg
    zoxide add /usr/src/linux
}

# ======================
# Advanced ZSH Integration
# ======================

# Dynamic completion for Gentoo directories
_zoxide_gentoo_complete() {
    local -a dirs
    dirs=(
        /etc/portage(/)
        /usr/portage(/)
        /var/db/repos(/)
        /var/db/pkg(/)
        /usr/src/linux(/)
        ~/.config(/)
    )
    _describe 'directory' dirs
}
compdef _zoxide_gentoo_complete j

# History integration - log directory changes
function zoxide-add-history() {
    local last_command=$(fc -ln -1)
    if [[ "$last_command" =~ ^(cd|j|z|zi) ]]; then
        zoxide add "$(pwd)"
    fi
}
add-zsh-hook zshaddhistory zoxide-add-history

# ======================
# Performance Optimizations
# ======================

# Use a more efficient hashing algorithm for Gentoo's deep directory structures
export _ZO_HASH_CMD='xxh64sum'

# Parallel processing for database updates
if command -v parallel >/dev/null; then
    export _ZO_UPDATE_CMD="parallel -j $(nproc) -- zoxide add"
fi

# ======================
# Final Initialization
# ======================

# Verify zoxide is working
if ! command -v zoxide >/dev/null; then
    print -P "%F{$_ZO_FG_ERROR}Warning:%f zoxide not found. Install with:"
    print -P "  %F{$_ZO_FG_NEW}emerge -a app-shells/zoxide%f"
fi
