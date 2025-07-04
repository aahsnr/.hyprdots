# BAT Configuration
export BAT_THEME="Catppuccin-mocha"
export BAT_STYLE="numbers,changes,header"

# Use bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Useful aliases
alias cat='bat --paging=never'
alias batl='bat --paging=always'  # Use batl instead of overriding less
alias batp='bat --plain'          # Plain output without decorations

# Fedora-specific aliases
alias dnf-log='bat /var/log/dnf.log'
alias dnf-repos='find /etc/yum.repos.d -name "*.repo" -exec bat {} \;'
alias fedora-release='bat /etc/fedora-release'

# Enhanced functions with git integration
batgit() {
    # Add git information to the output
    local git_info=""
    if git rev-parse --git-dir > /dev/null 2>&1; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local modified=$(git diff --name-only 2>/dev/null | wc -l)
        local staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
        git_info="[Branch: ${branch:-unknown}] [Modified: $modified] [Staged: $staged]"
        echo "Git Status: $git_info"
        echo "----------------------------------------"
    fi
    bat "$@"
}

# Fedora-specific utility functions
dnf-history() {
    if [[ -f "/var/log/dnf.log" ]]; then
        bat /var/log/dnf.log --language=log
    else
        echo "DNF log file not found"
    fi
}

dnf-rpm-log() {
    if [[ -f "/var/log/dnf.rpm.log" ]]; then
        bat /var/log/dnf.rpm.log --language=log
    else
        echo "DNF RPM log file not found"
    fi
}

# Function to view RPM spec files
spec() {
    if [[ -z "$1" ]]; then
        echo "Usage: spec <spec_file>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language="RPM Spec"
    else
        echo "Spec file not found: $1"
    fi
}

# Function to view package changelogs
changelog() {
    if [[ -z "$1" ]]; then
        echo "Usage: changelog <package_name>"
        return 1
    fi
    if rpm -q "$1" > /dev/null 2>&1; then
        rpm -q --changelog "$1" | bat --language=diff --plain
    else
        echo "Package not found or not installed: $1"
    fi
}

# Function to view system configuration files
sysconfig() {
    if [[ -z "$1" ]]; then
        echo "Usage: sysconfig <config_name>"
        echo "Available configs in /etc/sysconfig:"
        ls /etc/sysconfig/ 2>/dev/null || echo "Directory not accessible"
        return 1
    fi
    local config_file="/etc/sysconfig/$1"
    if [[ -f "$config_file" ]]; then
        bat "$config_file"
    else
        echo "Sysconfig file not found: $config_file"
    fi
}

# Function to view systemd unit files
unit() {
    if [[ -z "$1" ]]; then
        echo "Usage: unit <unit_name>"
        return 1
    fi
    local unit_file
    # Try to find the unit file
    unit_file=$(systemctl show -p FragmentPath "$1" 2>/dev/null | cut -d= -f2)
    if [[ -n "$unit_file" && -f "$unit_file" ]]; then
        bat "$unit_file" --language=systemd
    else
        echo "Unit file not found for: $1"
    fi
}

# Function to view SELinux policy files
sepolicy() {
    if [[ -z "$1" ]]; then
        echo "Usage: sepolicy <policy_name>"
        echo "Look for .te files in /usr/share/selinux/targeted/"
        return 1
    fi
    local policy_file
    if [[ -f "$1" ]]; then
        policy_file="$1"
    elif [[ -f "/usr/share/selinux/targeted/$1.te" ]]; then
        policy_file="/usr/share/selinux/targeted/$1.te"
    elif [[ -f "/usr/share/selinux/targeted/$1" ]]; then
        policy_file="/usr/share/selinux/targeted/$1"
    else
        echo "SELinux policy file not found: $1"
        return 1
    fi
    bat "$policy_file" --language=c
}

# Function to view Fedora-specific files
fedora-info() {
    echo "=== Fedora Release Information ==="
    if [[ -f "/etc/fedora-release" ]]; then
        bat /etc/fedora-release
    fi
    if [[ -f "/etc/os-release" ]]; then
        echo -e "\n=== OS Release Information ==="
        bat /etc/os-release
    fi
    if [[ -f "/etc/system-release" ]]; then
        echo -e "\n=== System Release Information ==="
        bat /etc/system-release
    fi
}

# Function to view container files
container-config() {
    if [[ -z "$1" ]]; then
        echo "Usage: container-config <dockerfile|containerfile>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language=dockerfile
    else
        echo "Container file not found: $1"
    fi
}

# Function to view kickstart files
kickstart() {
    if [[ -z "$1" ]]; then
        echo "Usage: kickstart <kickstart_file>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language=bash
    else
        echo "Kickstart file not found: $1"
    fi
}

# Function for viewing JSON with proper syntax highlighting
json() {
    if [[ -z "$1" ]]; then
        echo "Usage: json <json_file>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language=json
    else
        echo "JSON file not found: $1"
    fi
}

# Function for viewing YAML files
yaml() {
    if [[ -z "$1" ]]; then
        echo "Usage: yaml <yaml_file>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language=yaml
    else
        echo "YAML file not found: $1"
    fi
}

# Enhanced diff viewing with delta
export GIT_PAGER="delta"
export DELTA_PAGER="bat --plain"


# Find and view files with bat
fbat() {
    local file
    if command -v fzf >/dev/null 2>&1; then
        file=$(fd --type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}') && bat "$file"
    else
        echo "fzf not installed. Install with: sudo dnf install fzf"
    fi
}

# Alternative if fd is installed as fd-find
if command -v fd-find >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    alias fd='fd-find'
fi


# Function for large files with minimal styling
batfast() {
    bat --style=plain --paging=always "$@"
}

# Function to check file size before using bat
smartbat() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        if [[ $size -gt 1048576 ]]; then  # 1MB
            echo "Large file detected ($(( size / 1024 ))KB). Using plain mode."
            batfast "$file"
        else
            bat "$file"
        fi
    else
        echo "File not found: $file"
    fi
}

# Function to view mock configuration
mock-config() {
    if [[ -z "$1" ]]; then
        echo "Usage: mock-config <config_name>"
        echo "Available configs in /etc/mock/:"
        find /etc/mock/ -name "*.cfg" -type f 2>/dev/null | xargs -n1 basename 2>/dev/null || echo "No mock configs found"
        return 1
    fi
    local config_file
    if [[ -f "$1" ]]; then
        config_file="$1"
    elif [[ -f "/etc/mock/$1.cfg" ]]; then
        config_file="/etc/mock/$1.cfg"
    elif [[ -f "/etc/mock/$1" ]]; then
        config_file="/etc/mock/$1"
    else
        echo "Mock config file not found: $1"
        return 1
    fi
    bat "$config_file" --language=python
}

# Function to view RPM build logs
rpm-buildlog() {
    if [[ -z "$1" ]]; then
        echo "Usage: rpm-buildlog <log_file>"
        return 1
    fi
    if [[ -f "$1" ]]; then
        bat "$1" --language=log
    else
        echo "Build log file not found: $1"
    fi
}

# Function to view DNF configuration
dnf-config() {
    if [[ -f "/etc/dnf/dnf.conf" ]]; then
        echo "=== DNF Main Configuration ==="
        bat /etc/dnf/dnf.conf
    fi
    
    echo -e "\n=== DNF Repository Files ==="
    find /etc/yum.repos.d/ -name "*.repo" -type f 2>/dev/null | while read -r repo; do
        echo "--- $(basename "$repo") ---"
        bat "$repo"
        echo
    done
}
