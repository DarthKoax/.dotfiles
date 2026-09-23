#!/usr/bin/env bash
# Create and enter a new sandbox directory
function sandbox() {
    # Ensure the base directory exists
    local base_dir="$HOME/.sandbox"
    mkdir -p "$base_dir"
    
    # Create a unique temporary directory inside the base directory
    local tmp_dir
    tmp_dir=$(mktemp -d "$base_dir/tmp.XXXXXX")
    
    # Navigate into the new directory
    cd "$tmp_dir" || return
    echo "Entered sandbox: $tmp_dir"
}

# Clean up all directories inside the sandbox folder
function sandclean() {
    local base_dir="$HOME/.sandbox"
    
    if [[ -d "$base_dir" ]]; then
        echo "Cleaning up $base_dir..."
        # Remove everything inside the sandbox directory
        rm -rf "$base_dir"/*
        echo "Sandbox cleared."
    else
        echo "No sandbox directory found at $base_dir."
    fi
}

alias sand='sandbox'