#!zsh

# Login shell setup.
typeset -U path
path=(
  "$HOME/.local/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/local/sbin"
  "/usr/sbin"
  "/sbin"
)
# export PATH="${(j.:.)path}"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -R"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat --language=man --plain --paging=always'"
export LESS="-J -g -i -w -M -R -F -X"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh --shims)"
fi

# vim: set ft=zsh
