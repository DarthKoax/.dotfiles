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
HISTSIZE=1000
HISTFILESIZE=2000

#enables secrets
if [ -f ~/.bash_shell_colors.sh ]; then
    
    source ~/.bash_shell_colors.sh
fi

#enable aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#enables secrets
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
fi

#Enables FZF completion
if [ -f ~/.config/fzf/completion.bash ]; then
    source ~/.config/fzf/completion.bash
fi
#Enables FZF bindings
if [ -f ~/.config/fzf/key-bindings.bash ]; then
    source ~/.config/fzf/key-bindings.bash
fi



#enables functions
for file in ~/dotfiles/bash_functions/*.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done


LS_COLORS="di=34:ex=32:ln=36:pi=33:so=35:bd=34;4:cd=33;4:su=41:*.tar=31:*.zip=31"
export LS_COLORS


# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# export PS1='|\[\033[32m\]$(parse_git_branch)\[\033[00m\] \u@\h \w \n├── $ '
export PS1="${COLOR_GREEN}\$(parse_git_branch)${COLOR_RESET}${COLOR_CYAN}\u@\h${COLOR_RESET} ${COLOR_MAGENTA}\w $ ${COLOR_RESET}"


export PATH=$PATH:~/dotfiles/bin:/usr/local/bin:/usr/bin:/usr/local/go/bin
