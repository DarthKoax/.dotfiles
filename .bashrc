# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if command -v tmux>/dev/null; then
   [[ ! $TERM =~ screen ]] && [ -n "$PS1" ] && exec tmux
fi


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000


#Enables functions
for file in ~/.dotfiles/bashrc.d/*.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

if [ -f "$(dirname -- "${BASH_SOURCE[0]}")/.bashrc_env_custom.sh" ]; then
    source "$(dirname -- "${BASH_SOURCE[0]}")/.bashrc_env_custom.sh"
fi

if [ -f "$(dirname -- "${BASH_SOURCE[0]}")/.bashrc_secrets.sh" ]; then
    source "$(dirname -- "${BASH_SOURCE[0]}")/.bashrc_secrets.sh"
fi

# #Enables FZF completion
# if [ -f ~/.config/fzf/completion.bash ]; then
#     source ~/.config/fzf/completion.bash
# fi
# #Enables FZF bindings
# if [ -f ~/.config/fzf/key-bindings.bash ]; then
#     source ~/.config/fzf/key-bindings.bash
# fi


# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PS1="${PROMPT_BRIGHT_CYAN}${PROMPT_BOLD}\$(parse_git_branch)${PROMPT_BRIGHT_GREEN}\$(parse_kube_namespace)${PROMPT_RESET}${PROMPT_CYAN}\u@\h${PROMPT_RESET} ${PROMPT_MAGENTA}\w $ ${PROMPT_RESET}"
export PATH=$PATH:/usr/local/bin:/usr/bin:/usr/local/go/bin

#$(go env GOPATH)
