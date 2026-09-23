#!/usr/bin/env bash
# # If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac
export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# if command -v tmux>/dev/null; then
#    [[ ! $TERM =~ screen ]] && [ -n "$PS1" ] && exec tmux
# fi
export COLORTERM=truecolor
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=20000
LS_COLORS="di=34:ex=32:ln=36:pi=33:so=35:bd=34;4:cd=33;4:su=41:*.tar=31:*.zip=31"
export LS_COLORS

# Load scripts from bashrc.d directory
if [ -d "$DOTFILES_DIR/bashrc.d" ]; then
    for script in "$DOTFILES_DIR/bashrc.d"/*; do
        [ -f "$script" ] && source "$script"
    done
fi

# Enables secrets
if [ -f "$DOTFILES_DIR/.bashrc_secrets.sh" ]; then
    source "$DOTFILES_DIR/.bashrc_secrets.sh"
fi

if [ -f "$DOTFILES_DIR/.bashrc_env_custom.sh" ]; then
    source "$DOTFILES_DIR/.bashrc_env_custom.sh"
fi

# #enable aliases
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# #Enables FZF completion
# if [ -f ~/.config/fzf/completion.bash ]; then
#     source ~/.config/fzf/completion.bash
# fi
# #Enables FZF bindings
# if [ -f ~/.config/fzf/key-bindings.bash ]; then
#     source ~/.config/fzf/key-bindings.bash
# fi

# #enables functions
# for file in ~/dotfiles/bash_functions/*.sh; do
#     [ -r "$file" ] && [ -f "$file" ] && source "$file"
# done

# # enable programmable completion features
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

export PS1='|\[\033[32m\]$(parse_git_branch)\[\033[00m\] \u@\h \w \n├── $ '
# export PS1="${COLOR_GREEN}\$(parse_git_branch)${COLOR_RESET}${COLOR_CYAN}\u@\h${COLOR_RESET} ${COLOR_MAGENTA}\w $ ${COLOR_RESET}"

export PATH=$PATH:~/.dotfiles/bin/nvim-linux-x86_64/bin:/usr/local/bin:/usr/bin:/usr/local/go/bin:$(go env GOPATH)/bin
