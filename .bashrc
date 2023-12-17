#!/bin/bash
# shellcheck shell=bash source=/dev/null

[[ $- != *i* ]] && return # if not running interactively, don't do anything

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
shopt -s histappend    # Append to the Bash history file, rather than overwriting it
HISTSIZE=1000          # number of lines of history to store in memory
HISTFILESIZE=10000     # number of lines of history to store in the history file

[[ $DISPLAY ]] && shopt -s checkwinsize

# source
source_exist() {
  [[ -r "$1" ]] && source "$1"
}
source_exist "/usr/local/opt/fzf/shell/completion.bash" ||
  source_exist "/usr/share/fzf/completion.bash"
source_exist "/usr/local/opt/fzf/shell/key-bindings.bash" ||
  source_exist "/usr/share/fzf/key-bindings.bash"
source_exist "/usr/local/opt/git/etc/bash_completion.d/git-prompt.sh" ||
  source_exist "/usr/share/git/completion/git-prompt.sh"
source_exist "/usr/local/opt/git/etc/bash_completion.d/git-completion.bash" ||
  source_exist "/usr/share/git/completion/git-completion.bash"
source_exist "$HOME/.local/share/nvm/nvm.sh" ||
  source_exist "/usr/local/opt/nvm/nvm.sh"
source_exist "$HOME/.gvm/scripts/gvm"
unset source_exist

# export
case "$TERM" in
*-256color)
  __exit_ps1() {
    ex=$?
    [ $ex -eq 0 ] && return
    printf -- "\033[0;37m#exit:%s\033[0m\n" "$ex"
    return $ex
  }
  PROMPT_COMMAND="__exit_ps1"

  if [[ ${EUID} != 0 ]]; then
    PS1='\[\033[0;32m\]\u\[\033[0m\]'
  else
    PS1='\[\033[0;31m\]\u\[\033[0m\]'
  fi
  PS1=$PS1':\[\033[0;35m\]\h\[\033[0m\]@\[\033[0;34m\]\w\[\033[0m\]'

  if type pyenv >/dev/null 2>&1; then
    __pyenv_ps1() {
      cur="$(pyenv version-name)"
      [[ "$cur" == "system" ]] && return
      printf -- "(pyenv %s)" "$cur"
    }
    PS1='\[\033[0;37m\]$(__pyenv_ps1)'$PS1
  fi
  if type gvm-prompt >/dev/null 2>&1; then
    PS1='\[\033[0;37m\](gvm $(gvm-prompt))'$PS1
  fi
  if type nvm >/dev/null 2>&1; then
    __nvm_ps1() {
      cur="$(nvm current)"
      [[ -z "$cur" ]] && return
      printf -- "(nvm %s)" "$cur"
    }
    PS1='\[\033[0;37m\]$(__nvm_ps1)'$PS1
  fi

  if type __git_ps1 >/dev/null 2>&1; then
    PS1=$PS1'\[\033[0;33m\]$(__git_ps1 "(%s)")\[\033[0m\]'
  fi

  PS1=$PS1'\[\033[0m\] \$ '
  ;;
*)
  __exit_ps1() {
    ex=$?
    [ $ex -eq 0 ] && return
    printf -- "#exit:%s\n" "$ex"
    return $ex
  }
  PROMPT_COMMAND="__exit_ps1"

  PS1='\u@\h:\w \$ '
  ;;
esac

# alias
if type nvim >/dev/null 2>&1; then
  alias vim="nvim"
  alias vi="nvim --noplugin"
elif type vim >/dev/null 2>&1; then
  alias vi="vim --noplugin"
fi
alias more='less'
alias la='ls -AF'
alias l='la -C'
alias ll='la -l'
alias rm='rm -i -v' # confirm before removing something
alias cp="cp -i"    # confirm before overwriting something
alias rg='rg --color=auto'
case "$(uname)" in
Darwin)
  alias ls='ls -G'
  alias grep='grep -G'
  alias fgrep='fgrep -G'
  ;;
Linux)
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'
  alias rm='rm --preserve-root'
  ;;
esac
alias px='SOCKS_PROXY="socks5://127.0.0.1:1080" HTTP_PROXY="http://127.0.0.1:8118" HTTPS_PROXY="http://127.0.0.1:8118" ALL_PROXY="socks5://127.0.0.1:1080"'

# vim:fdm=indent
