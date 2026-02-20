#!zsh

bindkey -v
zmodload -F zsh/terminfo +p:terminfo
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line # <S-v> to edit command line in $EDITOR
bindkey '^L' autosuggest-accept # <C-l> to accept the current autosuggestion
bindkey '^H' autosuggest-clear # <C-h> to clear the current autosuggestion
bindkey -r "^T" # Unbind default transpose-chars
bindkey "^F" fzf-file-widget # <C-f> to fzf-file-widget for file searching
# bindkey "^G" fzf-search-widget
bindkey -r "^[c"
