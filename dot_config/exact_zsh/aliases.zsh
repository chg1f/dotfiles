#!zsh

alias PX='HTTP_PROXY=http://127.0.0.1:1080 HTTPS_PROXY=http://127.0.0.1:1080 SOCKS_PROXY=socks5://127.0.0.1:1080 ALL_PROXY=socks5://127.0.0.1:1080'
# alias -g Q="1>/dev/null 2>/dev/null"
# alias -g Q1="1>/dev/null"
# alias -g Q2="2>/dev/null"

alias path='print -l ${(s/:/)PATH} | nl'

# if command -v hurl &> /dev/null; then
#   alias hurl="hurl --error-format=long"
# fi

if command -v python3 &>/dev/null; then
  alias uuid7='python3 -c "import uuid; print(uuid.uuid7())"'
  alias uuid4='python3 -c "import uuid; print(uuid.uuid4())"'
  alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))"'
  alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
fi
if command -v eza &>/dev/null; then
  EZA_PARAMS=('--git' '--group' '--group-directories-first' '--time-style=+%y-%m-%d %H:%M:%S %a' '--color-scale=all')
  alias ls='eza $EZA_PARAMS'
  alias l='eza $EZA_PARAMS --git-ignore'
  alias ll='eza $EZA_PARAMS --all --header --long'
  alias llm='eza $EZA_PARAMS --all --header --long --sort=modified'
  alias la='eza $EZA_PARAMS --long --binary --header --links --inode --group --group-directories-first --modified --all --blocksize'
  alias lx='eza $EZA_PARAMS --long --binary --header --links --inode --group --group-directories-first --modified --all --blocksize --classify=auto'
  alias lt='eza $EZA_PARAMS --tree'
fi
if command -v chezmoi 2>&1 >/dev/null; then
  alias cz='chezmoi'
  alias cz-manages='chezmoi managed --tree --path-style=source-relative --color=auto --no-pager'
  # cz() {
  #   case "$1" in
  #   # t)  shift; command chezmoi managed --tree "$@" ;;
  #   # ts) shift; command chezmoi managed --tree --path-style=source-relative "$@" ;;
  #   # s)  shift; command chezmoi status "$@" ;;
  #   # d)  shift; command chezmoi diff "$@" ;;
  #   # src) shift; cd "$(command chezmoi source-path)" || return ;;
  #   # a)  shift; command chezmoi apply "$@" ;;
  #   manages) chezmoi managed --tree --path-style=source-relative --color=auto --no-pager ;;
  #   *) command chezmoi "$@" ;;
  #   esac
  # }
  # compdef _chezmoi cz
fi
