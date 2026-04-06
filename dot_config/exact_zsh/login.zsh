#!zsh

# Login shell setup.
typeset -U path

path=(
  "$HOME/.local/bin"
  "/opt/homebrew/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/local/sbin"
  "/usr/sbin"
  "/sbin"
)

export PATH="${(j.:.)path}"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -R"

export LESS="-g -i -w -M -R -F -X"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

export MANPAGER="col -bx | bat -p -l man"

export GOPATH="$XDG_DATA_HOME/go"

# Homebrew shellenv is expensive; avoid unless you really need it.
# If you must, do it here (login only), and only if brew exists.
# if command -v brew >/dev/null 2>&1; then
# fi
if command -v brew 2>&1 >/dev/null; then
  eval "$(brew shellenv)"
  export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/Brewfile"
  export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_ENV_HINTS=1
  export HOMEBREW_NO_INSTALL_FROM_API=1
fi


# vim: set ft=zsh
