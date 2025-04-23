# Modern CLI tool replacements
alias cat='bat --style=plain'                # bat instead of cat
alias ls='eza --group-directories-first'     # eza instead of ls
alias ll='eza -l --group-directories-first'  # detailed list
alias la='eza -la --group-directories-first' # include hidden files
alias tree='eza --tree'                      # tree view
alias find='fd'                              # fd instead of find
alias grep='rg'                              # ripgrep instead of grep
alias diff='colordiff'                       # colored diff output

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'

# Git aliases and improvements
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gst='git status'
alias gl='git log --oneline'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gf='git fetch'

# Development tools
alias py='python3'
alias pip='pip3'
alias node='node'
alias npm='npm'
alias k='kubectl'
alias tf='terraform'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs'

# Quick directory switching
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Add some useful eza aliases
alias lt='eza --tree --level=2'              # Tree view, 2 levels deep
alias ltt='eza --tree --level=3'             # Tree view, 3 levels deep
alias lg='eza -l --git'                      # Show git status in list
alias lm='eza -l --sort=modified'            # Sort by modified date
alias lz='eza -l --sort=size'                # Sort by size
