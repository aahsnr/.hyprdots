# Enable Starship
eval "$(starship init zsh)"

# Optimize Git for Gentoo
export GIT_OPTIONAL_LOCKS=0

# Gentoo-specific optimizations
alias emerge='nocorrect emerge'
alias ebuild='nocorrect ebuild'
alias equery='nocorrect equery'

# Cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Create cache directory if missing
[[ ! -d ~/.zsh/cache ]] && mkdir -p ~/.zsh/cache
