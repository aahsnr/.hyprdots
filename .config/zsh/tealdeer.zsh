alias t='tldr'

tldrf() {
    if [[ -n "$1" ]]; then
        tldr -f "$@"
    else
        echo "Usage: tldrf <command>"
        echo "Faster tldr with local cache only"
    fi
}

# Search pages by description or content
tldr-search() {
    if [[ -n "$1" ]]; then
        tldr --list | grep -i "$1" | xargs -n 1 tldr
    else
        echo "Usage: tldr-search <pattern>"
        echo "Search tldr pages by description"
    fi
}

# Quick Gentoo-specific commands
alias tldr-emerge='tldr emerge'
alias tldr-portage='tldr portage'
alias tldr-equery='tldr equery'

