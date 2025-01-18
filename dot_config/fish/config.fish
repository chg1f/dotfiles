#/usr/bin/env fish

set -x PATH $HOME/.local/bin /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x PAGER less
set -x EDITOR vim
set -x VISUAL vim
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x HOMEBREW_PREFIX /usr/local
set -x HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/homebrew/Brewfile
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x HOMEBREW_NO_ENV_HINTS 1
set -x HOMEBREW_NO_INSTALL_FROM_API 1
set -x TMUX_PLUGIN_MANAGER_PATH $XDG_DATA_HOME/tmux/plugins

if status is-interactive
    fish_vi_key_bindings
end
