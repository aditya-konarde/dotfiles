# Colors and prompt
autoload -U colors && colors

# Modern prompt with git information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ${vcs_info_msg_0_} %# '
