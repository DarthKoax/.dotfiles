#!/bin/bash
function get_linux_distribution() {
    if [ -f "/etc/os-release" ]; then
        # Modern distributions use /etc/os-release
        . /etc/os-release
        echo "$ID"
    elif [ -f "/etc/redhat-release" ]; then
        # Older Red Hat based distributions
        echo "redhat"
    elif [ -f "/etc/debian_version" ]; then
        # Debian-based distributions
        echo "debian"
    else
        echo "unknown"
    fi
}