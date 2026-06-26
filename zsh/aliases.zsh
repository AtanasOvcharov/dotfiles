# Better ls 
alias ls='eza --group-directories-first --icons'
alias ll='eza -l --group-directories-first --icons --git'
alias la='eza -la --group-directories-first --icons --git'

alias tree1='eza --tree --level=1 --icons --group-directories-first --git-ignore'
alias tree2='eza --tree --level=2 --icons --group-directories-first --git-ignore'
alias tree3='eza --tree --level=3 --icons --group-directories-first --git-ignore'

compdef eza=ls # reuse the ls completion for eza

# Better cat
alias cat='batcat'

# Disk usage
alias df='df -h'

# Git 
alias gst='git status'
alias glog='git log --oneline --graph --decorate -n'
