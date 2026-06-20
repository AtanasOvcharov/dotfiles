# Better ls 
alias ls='eza --icons=auto'
alias ll='eza --icons=auto -l --git'
alias la='eza --icons=auto -la --git'

alias tree='eza --icons=auto --tree'
alias tree1='eza --icons=auto --tree --level=1'
alias tree2='eza --icons=auto --tree --level=2'
alias tree3='eza --icons=auto --tree --level=3'

compdef eza=ls # reuse the ls completion for eza

# Better cat
alias cat='batcat'

# Disk usage
alias df='df -h'

# Git 
alias gst='git status'
alias glog='git log --oneline --graph --decorate -n'
