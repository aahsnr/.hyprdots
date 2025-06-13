# BAT configuration
export BAT_THEME="Catppuccin-mocha"
export BAT_STYLE="numbers,changes,header"
export BAT_PAGER="less -FRX"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Use bat as the pager for various commands
alias cat='bat --paging=never'
alias less='bat --paging=always'
alias more='bat --paging=always'
