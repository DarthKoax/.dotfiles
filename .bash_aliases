# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lh'
alias l='ls -CF'

# Enable aliases to be sudo’ed
alias sudo='sudo '

#WSL 
alias exp="explorer.exe ."
alias mantel="code /mnt/c/Users/kylec/Documents/mantel"
alias winget="winget.exe"


alias hg='history | grep'


alias taillog='f() { tail -F "$1" | while read LOGLINE; do curl -X POST -d "log_line=$LOGLINE" http://$LOGSERVER/log; done; unset -f f; }; f

# Credits:
# https://github.com/CoreyMSchafer/dotfiles/