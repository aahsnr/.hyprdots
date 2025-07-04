alias fd='fd-find'
alias find='fd-find'
command -v dust >/dev/null 2>&1 && alias du='dust'
command -v procs >/dev/null 2>&1 && alias ps='procs'
command -v rg >/dev/null 2>&1 && alias grep='rg'
command -v zoxide >/dev/null 2>&1 && alias cd='z'

# ===== Fedora-specific Aliases =====
alias dnf='dnf --color=always'
alias dnf-update='sudo dnf update && sudo dnf autoremove'
alias dnf-clean='sudo dnf clean all'
alias dnf-history='dnf history'
alias dnf-repos='dnf repolist'

# Systemctl aliases
alias sctl='systemctl'
alias sctle='sudo systemctl enable'
alias sctld='sudo systemctl disable'
alias sctls='sudo systemctl start'
alias sctlr='sudo systemctl restart'
alias sctlS='sudo systemctl stop'
alias sctlq='systemctl status'

# Flatpak aliases
if command -v flatpak >/dev/null 2>&1; then
  alias fp='flatpak'
  alias fpi='flatpak install'
  alias fpu='flatpak update'
  alias fpr='flatpak uninstall'
  alias fps='flatpak search'
  alias fpl='flatpak list'
fi

# ===== Additional Fedora Tools =====
# Podman aliases (if available)
if command -v podman >/dev/null 2>&1; then
  alias docker='podman'
  alias pd='podman'
  alias pdi='podman images'
  alias pdc='podman ps'
  alias pdr='podman run'
  alias pds='podman start'
  alias pdS='podman stop'
fi

