#!zsh

bindkey -v

# # Optional terminfo support
zmodload -F zsh/terminfo +p:terminfo

# History search in vicmd
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Edit command line in $EDITOR from vicmd
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line

# Keep Ctrl-L for screen clear
bindkey '^L' clear-screen

# Autosuggestions
bindkey '^L' autosuggest-accept
# bindkey '^H' autosuggest-clear
