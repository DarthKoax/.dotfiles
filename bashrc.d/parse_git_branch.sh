#!/usr/bin/env bash
function parse_git_branch() {
    local branch
    branch=$(git branch 2>/dev/null | sed -n '/^[*]/s/^[* ]*//p' | head -n 1)
    if [[ -n "$branch" ]]; then
        echo "($branch) "
    fi
}

function parse_kube_namespace() {
    # If 'oc' is available, use 'oc project --short' for the fastest, most reliable output
    if command -v oc &> /dev/null; then
        local ns
        ns=$(oc project --short 2> /dev/null)
        if [[ -n "$ns" ]]; then
            echo "($ns) "
        fi
    # Fallback to kubectl if oc is not present or not desired
    elif command -v kubectl &> /dev/null; then
        local ns
        ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2> /dev/null)
        if [[ -n "$ns" ]]; then
            echo "($ns) "
        fi
    fi
}