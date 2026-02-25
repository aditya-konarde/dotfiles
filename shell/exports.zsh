# Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Source secrets if they exist
[ -f ~/.secrets/api_keys.sh ] && source ~/.secrets/api_keys.sh
