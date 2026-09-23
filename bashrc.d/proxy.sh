#!/usr/bin/env bash
# Toggle proxy on
function proxon() {
    # Replace with your actual proxy URL
    export http_proxy="http://proxy.example.com:8080"
    export https_proxy="http://proxy.example.com:8080"
    export ftp_proxy="http://proxy.example.com:8080"
    export no_proxy="localhost,127.0.0.1,.local"
    
    # Export lowercase variants for compatibility
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$https_proxy
    export FTP_PROXY=$ftp_proxy
    export NO_PROXY=$no_proxy
    
    echo "Proxy enabled."
}

# Toggle proxy off
function proxoff() {
    unset http_proxy https_proxy ftp_proxy no_proxy
    unset HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY
    echo "Proxy disabled."
}

# Function to show status in prompt
function parse_proxy_status() {
    if [[ -n "$http_proxy" ]]; then
        echo "(proxy)"
    fi
}