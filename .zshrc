#!/bin/zsh

# Performance optimization
zmodload zsh/zprof  # Uncomment to profile shell startup time
setopt NO_BEEP
setopt NO_HIST_BEEP

# History configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY       # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS      # Don't record duplicates
setopt HIST_IGNORE_SPACE     # Don't record commands starting with space
setopt HIST_VERIFY
setopt SHARE_HISTORY         # Share history between sessions
setopt APPEND_HISTORY        # Don't overwrite history

# Directory navigation
setopt AUTO_CD              # Just type directory name to cd
setopt AUTO_PUSHD          # Push directories to stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion system
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'

# Key bindings
bindkey -e  # Use emacs key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Colors and prompt
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Modern prompt with git information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ${vcs_info_msg_0_} %# '

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
alias dk='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs'

# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Extract any archive
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick directory switching
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Enhanced cheatsheet with new tools
cheatsheet() {
    echo "\n\033[1;34m=== 🚀 ZSH Cheatsheet ===\033[0m\n"
    
    echo "\033[1;32m📂 Modern CLI Tools\033[0m"
    echo "• bat → Enhanced cat with syntax highlighting"
    echo "• fd → Modern alternative to find"
    echo "• rg → Ultra-fast grep alternative"
    echo "• eza → Modern ls replacement with git integration"
    echo "• fzf → Fuzzy finder (Ctrl+R for history, Ctrl+T for files)"
    
    echo "\n\033[1;32m📂 Directory Listing (eza)\033[0m"
    echo "• ls → Basic listing with directories first"
    echo "• ll → Detailed list view"
    echo "• la → Show hidden files"
    echo "• lt → Tree view (2 levels)"
    echo "• ltt → Tree view (3 levels)"
    echo "• lg → List with git status"
    echo "• lm → Sort by modified date"
    echo "• lz → Sort by size"
    
    echo "\n\033[1;32m🐳 Docker Shortcuts\033[0m"
    echo "• dk → docker"
    echo "• dc → docker-compose"
    echo "• dps → docker ps"
    echo "• di → docker images"
    echo "• dex → docker exec -it"
    echo "• dlog → docker logs"
    
    echo "\n\033[1;32m🔧 Git Shortcuts\033[0m"
    echo "• gst → git status"
    echo "• ga → git add"
    echo "• gc → git commit"
    echo "• gp → git push"
    echo "• gd → git diff"
    echo "• gb → git branch"
    echo "• gl → git log (oneline)"
    
    echo "\n\033[1;32m⚡️ Development Tools\033[0m"
    echo "• py → python3"
    echo "• pip → pip3"
    echo "• k → kubectl"
    echo "• tf → terraform"
    
    echo "\n\033[1;32m📦 Archive Extraction\033[0m"
    echo "• extract any-archive.* → auto-extract any archive"
    echo "  Supports: tar.gz, zip, rar, 7z, and more"
    
    echo "\n\033[1;32m⌨️  Key Bindings\033[0m"
    echo "• Ctrl+R → fuzzy search history (with fzf)"
    echo "• Ctrl+T → fuzzy find files (with fzf)"
    echo "• Alt+C → fuzzy change directory (with fzf)"
    echo "• Ctrl+Left/Right → move between words"
    echo "• Ctrl+K → delete to end of line"
    echo "• Ctrl+U → delete entire line"
    
    echo "\n\033[1;32m💡 Tips\033[0m"
    echo "• Use bat for syntax-highlighted file viewing"
    echo "• rg is faster than grep for code searching"
    echo "• fd respects .gitignore by default"
    echo "• eza's git integration shows file status in listings"
    echo "• fzf works in many commands (kill, ssh, etc.)"
    echo ""
}

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Add some useful eza aliases
alias lt='eza --tree --level=2'              # Tree view, 2 levels deep
alias ltt='eza --tree --level=3'             # Tree view, 3 levels deep
alias lg='eza -l --git'                      # Show git status in list
alias lm='eza -l --sort=modified'            # Sort by modified date
alias lz='eza -l --sort=size'                # Sort by size

# Auto-start Zellij if available and not already inside a session
if command -v zellij &>/dev/null && [ -z "$ZELLIJ" ] && [[ $- == *i* ]] && [ -z "$VSCODE_IPC_HOOK_CLI" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ -z "$SSH_TTY" ]; then
    exec zellij
fi
