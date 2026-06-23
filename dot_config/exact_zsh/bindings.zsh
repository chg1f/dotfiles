#!zsh

bindkey -v

# Bind a widget only when it is already available.
bind-if-widget() {
  local keymap="$1"
  local key="$2"
  local widget="$3"

  if zle -la 2>/dev/null | grep -qx -- "$widget"; then
    bindkey -M "$keymap" "$key" "$widget"
  fi
}

# <C-r>: Atuin history search.
bind-if-widget emacs '^R' atuin-search
bind-if-widget viins '^R' atuin-search-viins
bind-if-widget vicmd '^R' atuin-search-vicmd

# <C-e>: fzf grep search.
bind-if-widget emacs '^E' fzf-grep-widget
bind-if-widget viins '^E' fzf-grep-widget
bind-if-widget vicmd '^E' fzf-grep-widget

# <C-g>: fzf directory jump.
bind-if-widget emacs '^G' fzf-cd-widget
bind-if-widget viins '^G' fzf-cd-widget
bind-if-widget vicmd '^G' fzf-cd-widget

# <M-c>: disabled in shell layer so Alt stays available to terminal/Zellij.
bindkey -M emacs -r '^[c'
bindkey -M viins -r '^[c'
bindkey -M vicmd -r '^[c'

# j/k: history substring search in vicmd.
bind-if-widget vicmd 'j' history-substring-search-down
bind-if-widget vicmd 'k' history-substring-search-up

# V: edit current command in $EDITOR from vicmd.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line

# <C-f>: accept autosuggestion
bindkey -M viins '^F' autosuggest-accept

# <C-l>: clear and redraw the screen.
bindkey -M emacs '^L' clear-screen
bindkey -M viins '^L' clear-screen
bindkey -M vicmd '^L' clear-screen

# vim: set ft=zsh
