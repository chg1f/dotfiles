#/usr/bin/env fish

set -x PATH $HOME/.local/bin /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x PAGER less
set -x MANPAGER "col -bx | bat -p -l man"
# set -x LESS "-g -i -M -R -S -w -X -z-4"
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
set -x FZF_DEFAULT_OPTS "--height=50% --layout=reverse --cycle --bind ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-e:preview-down,ctrl-y:preview-up"

# fisher update
if status is-interactive
    alias PX="HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 SOCKS_PROXY=socks5://127.0.0.1:7890 ALL_PROXY=socks5://127.0.0.1:7890"
    alias NLH="LEFTHOOK=0"
    alias cat="bat -p"
    alias vi="vim"
    # alias vim="nvim"

    fish_vi_key_bindings
    bind -M insert \b suppress-autosuggestion
    bind -M insert \cl accept-autosuggestion
    bind -M visual v edit_command_buffer
    fzf_configure_bindings --directory=\cf --git_status=\cs --git_log=\cg --variables=
    # set fzf_preview_dir_cmd eza --all --color=always

    set -U fish_greeting
    # set -U __done_min_cmd_duration 5000
    # set -U --append __done_exclude '^git (?!push|pull|fetch)'

    set -U tide_prompt_add_newline_before true
    set -U tide_prompt_transient_enabled true
    set -U tide_left_prompt_items vi_mode pwd direnv git newline character
    set -U tide_status_icon
    set -U tide_status_icon_failure
    set -U tide_status_color green
    set -U tide_status_color_failure red
    set -U tide_pwd_icon_unwritable RO
    set -U tide_pwd_markers .git package.json pyproject.toml go.work go.mod Cargo.toml build.zig
    set -U tide_git_icon
    set -U tide_git_color_branch cyan
    set -U tide_git_color_conflicted red
    set -U tide_git_color_dirty yellow
    set -U tide_git_color_operation green
    set -U tide_git_color_staged brgreen
    set -U tide_git_color_stash brblack
    set -U tide_git_color_untracked brred
    set -U tide_git_color_upstream brcyan
    set -U tide_character_icon \#
    set -U tide_character_vi_icon_default \#
    set -U tide_character_vi_icon_replace \#
    set -U tide_character_vi_icon_visual \#
    set -U tide_character_color brblack
    set -U tide_character_color_failure brblack
    set -U tide_vi_mode_icon_insert
    set -U tide_vi_mode_color_insert normal
    set -U tide_vi_mode_icon_default \[c\]
    set -U tide_vi_mode_color_default yellow
    set -U tide_vi_mode_icon_replace \[r\]
    set -U tide_vi_mode_color_replace red
    set -U tide_vi_mode_icon_visual \[v\]
    set -U tide_vi_mode_color_visual brred
    set -U tide_right_prompt_items status jobs python node go rustc zig context
    set -U tide_jobs_icon jobs
    set -U tide_jobs_color yellow
    set -U tide_direnv_icon direnv
    set -U tide_direnv_color green
    set -U tide_direnv_color_denied red
    set -U tide_python_icon python
    set -U tide_python_color brblack
    set -U tide_node_icon node
    set -U tide_node_color brblack
    set -U tide_rustc_icon rustc
    set -U tide_rustc_color brblack
    set -U tide_go_icon go
    set -U tide_go_color brblack
    set -U tide_zig_icon zig
    set -U tide_zig_color brblack
    set -U tide_context_always_display true
    set -U tide_context_color_default green
    set -U tide_context_color_root red
    set -U tide_context_color_ssh yellow
end
