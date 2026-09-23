#!/usr/bin/env bash
function git_worktree_checkout() {
    # Check if arguments were provided
    if [ -z "$1" ]; then
        echo "Usage: git_worktree_checkout <branch-name>"
        return 1
    fi

    # Get the branch name from command line arguments
    local BRANCH_NAME=$1

    # Check if we are currently in a git worktree
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        # Create a new branch based off of the current worktree
        git branch $BRANCH_NAME
    fi

    # Start at the current directory
    local dir=$PWD
    # Move up through the directory structure until we find .work_tree_top
    while [[ "$dir" != "" && ! -e "$dir/.work_tree_top" ]]; do
      dir=${dir%/*}
    done

    # If we didn't find the .work_tree_top file, exit with an error
    if [[ "$dir" == "" ]]; then
      echo ".work_tree_top file not found"
      return 1
    fi

    # The directory containing .work_tree_top file is our repo directory
    local TOP_REPO_DIR=$dir

    local BARE_REPO_DIR=$(basename $TOP_REPO_DIR)

    # Define worktree directory based on the repo directory and branch name
    local WORKTREE_DIR=$TOP_REPO_DIR/git-worktrees/$BRANCH_NAME

    # Add worktree for the specified branch
    git -C $TOP_REPO_DIR/$BARE_REPO_DIR.git worktree add $WORKTREE_DIR $BRANCH_NAME
}