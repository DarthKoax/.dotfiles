function git-switch-worktree(){
	# Check if arguments were provided
	if [ -z "$1" ]; then
		echo "Usage: git_switch_worktree <branch-name>"
		exit 1
	fi

	# Start at the current directory
	dir=$PWD

	# Move up through the directory structure until we find .work_tree_top
	while [[ "$dir" != "" && ! -e "$dir/.work_tree_top" ]]; do
		dir=${dir%/*}
	done

	# If we didn't find the .work_tree_top file, exit with an error
	if [[ "$dir" == "" ]]; then
		echo ".work_tree_top file not found"
		return
	fi

	# Define the path to the worktree directory based on the repo directory and branch name
	WORKTREE_DIR=$dir/git-worktrees/$1

	# If the worktree directory exists, navigate to it
	if [ -d "$WORKTREE_DIR" ]; then
		cd $WORKTREE_DIR
	else
		echo "No worktree found for branch '$1'"
	fi
}