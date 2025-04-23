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
