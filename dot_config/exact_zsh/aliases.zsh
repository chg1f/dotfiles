#!zsh

alias GNU='PATH="$(brew --prefix coreutils)/libexec/gnubin:$(brew --prefix findutils)/libexec/gnubin:$(brew --prefix diffutils)/libexec/gnubin:$PATH"'
alias UUTILS='PATH="$(brew --prefix uutils-coreutils)/libexec/gnubin:$(brew --prefix uutils-findutils)/libexec/gnubin:$(brew --prefix uutils-diffutils)/libexec/gnubin:$PATH"'
alias PX='HTTP_PROXY=http://127.0.0.1:1080 HTTPS_PROXY=http://127.0.0.1:1080 SOCKS_PROXY=socks5://127.0.0.1:1080 ALL_PROXY=socks5://127.0.0.1:1080 NO_PROXY=localhost,127.0.0.1,::1'
alias NLH="LEFTHOOK=0"
alias -g Q="1>/dev/null 2>/dev/null"
alias -g Q1="1>/dev/null"
alias -g Q2="2>/dev/null"

alias path='print -l ${(s/:/)PATH} | nl'
alias less='less -R'
alias tree='tree -C'
alias hurl='hurl --file-root . --cookie .cookie --variables-file .env --error-format long --continue-on-error'
# alias ssh-add='ssh-add --apple-use-keychain --apple-load-keychain'

if command -v python3 &>/dev/null; then
  alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))"'
  alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
fi

if command -v eza &>/dev/null; then
  EZA_PARAMS=('--git' '--group' '--group-directories-first' '--time-style=+%y-%m-%d %H:%M:%S %a' '--color-scale=all' '--color=always')
  alias ls='eza $EZA_PARAMS'
  alias l='eza $EZA_PARAMS --git-ignore'
  alias ll='eza $EZA_PARAMS --all --header --long'
  alias llm='eza $EZA_PARAMS --all --header --long --sort=modified'
  alias la='eza $EZA_PARAMS --long --binary --header --links --inode --group --group-directories-first --modified --all --blocksize'
  alias lx='eza $EZA_PARAMS --long --binary --header --links --inode --group --group-directories-first --modified --all --blocksize --classify=auto'
  alias lt='eza $EZA_PARAMS --tree'
fi

if command -v chezmoi 2>&1 >/dev/null; then
  alias cz='chezmoi --color=on'
fi
