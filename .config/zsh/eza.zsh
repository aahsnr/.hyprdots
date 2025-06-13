# Optimized eza aliases
alias ls='eza --view=default --icons=auto-fallback --color=auto'
alias ll='eza --view=detailed --color=auto'
alias la='eza --view=default --all --color=auto'
alias lt='eza --tree --level=2 --color=auto --icons=auto-fallback'
alias ldev='eza --view=dev --color=auto'
alias lquick='eza --view=quick --color=auto'

# Pipe-friendly version with forced colors
alias lsp='eza --color=always --icons=never --no-header'

# Set environment variables for better git detection
export EZA_GIT_DIR_CACHE="$HOME/.cache/eza/git_cache"
mkdir -p "$(dirname "$EZA_GIT_DIR_CACHE")"
