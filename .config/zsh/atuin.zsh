#!/usr/bin/zsh
# Atuin initialization
eval "$(atuin init zsh --disable-up-arrow)"

# Vim keybindings for Atuin
export ATUIN_KEYBINDING="vim"
bindkey -v  # Set vim mode for Zsh

# Custom vim-style bindings for Atuin
atuin-search-vim() {
  local selected=$(atuin search -i --cmd-only --height 20 --layout reverse | tac)
  if [[ -n $selected ]]; then
    BUFFER=$selected
    zle end-of-line
  fi
  zle redisplay
}
zle -N atuin-search-vim
bindkey '^r' atuin-search-vim

# Improved history navigation
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search

# Performance optimizations for Gentoo
export ATUIN_NOBIND="true"
export ATUIN_QUERY="command,exit,cwd,hostname,time,shell"
export ATUIN_SESSION_FILTER="0.1"  # Filter out very short sessions

# Optimize Atuin for Gentoo
export ATUIN_DB_WAL_ENABLED=1
export ATUIN_DB_CACHE_SIZE=-2000  # 2MB cache
export ATUIN_DB_JOURNAL_MODE=WAL
export ATUIN_DB_SYNC=1
export ATUIN_RUST_LOG="warn"  # Reduce logging verbosity
