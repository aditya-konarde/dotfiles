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
    echo "• d → docker"
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
