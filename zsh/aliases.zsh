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

# Zoxide
alias zz='zi'

# Clear terminal
alias cl='clear'

# Git 
alias gst='git status'

git_log_format='--graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %<(50,trunc)%s %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)"'
alias gl="git log $git_log_format"

