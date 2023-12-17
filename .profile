#!/bin/sh
# shellcheck shell=sh source=/dev/null

# PATH
append_path() {
  [ -d "$1" ] || return
  case ":${PATH}:" in
  *:"$1":*)
    PATH="${PATH%%:"$1":*}:${PATH#*:"$1":}"
    ;;
  esac
  export PATH="${PATH:+"$PATH:"}$1"
}
append_path "$HOME/.local/bin"
append_path "/usr/local/bin"
append_path "/usr/bin"
append_path "/bin"
append_path "/usr/local/sbin"
append_path "/usr/sbin"
append_path "/sbin"
unset append_path

# LANG
export LANG="${LANG:-en_US.UTF-8}"

# LC_ALL
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# PS1
export PS1='\u@\h:\w \$ '

# SHELL
if type zsh >/dev/null 2>&1; then
  export SHELL="${SHELL:-$(which zsh)}"
elif type bash >/dev/null 2>&1; then
  export SHELL="${SHELL:-$(which bash)}"
fi

# EDITOR
if type nvim >/dev/null 2>&1; then
  export EDITOR="${EDITOR:-"$(which nvim)"}"
elif type vim >/dev/null 2>&1; then
  export EDITOR="${EDITOR:-"$(which vim)"}"
elif type vi >/dev/null 2>&1; then
  export EDITOR="${EDITOR:-"$(which vi)"}"
fi

# PATH
if type less >/dev/null 2>&1; then
  export PAGER="${PAGER:-"$(which less)"}"
  if type src-hilite-lesspipe.sh >/dev/null 2>&1; then
    LESSPIPE="$(which src-hilite-lesspipe.sh)"
    export LESSOPEN="| ${LESSPIPE} %s"
    export LESS=' -RFX '
  fi
fi

case "$(uname)" in
Darwin)
  for profile in /usr/local/etc/profile.d/*.sh; do
    [ -r "$profile" ] && . "$profile"
  done
  ;;
linux*) ;;
esac

# SSH_AUTH_SOCK
type keychain >/dev/null 2>&1 && eval "$(keychain --eval --quiet --timeout 60)"

# GIT_*
if type git >/dev/null 2>&1; then
  export GIT_PS1_SHOWDIRTYSTATE=yes
  export GIT_PS1_SHOWSTASHSTATE=yes
  export GIT_PS1_SHOWUNTRACKEDFILES=yes
  export GIT_PS1_SHOWUPSTREAM=verbose
  export GIT_PS1_OMITSPARSESTATE=yes
  export GIT_PS1_DESCRIBE_STYLE=describe
  export GIT_PS1_HIDE_IF_PWD_IGNORED=yes
fi
# FZF_*
if type fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_R_OPTS='--preview "echo {}" --preview-window down:3:hidden:wrap'
  export FZF_CTRL_T_OPTS='--preview "echo {}" --preview-window down:3:hidden:wrap'
  export FZF_ALT_C_OPTS='--preview "echo {}" --preview-window down:3:hidden:wrap'
fi

export PYTHONIOENCODING='UTF-8'
# PYENV_*
if type pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  if type pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# vim:fdm=indent
