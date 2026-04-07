#!zsh

# Interactive shell configuration.
setopt PROMPT_SUBST
setopt INTERACTIVE_COMMENTS
setopt AUTO_CD
setopt NO_BEEP

# History behavior
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

HISTSIZE=200000
SAVEHIST=200000

if command -v codex 2>&1 >/dev/null; then
	export CODEX_HOME="$XDG_DATA_HOME/codex"
fi


if command -v atuin >/dev/null 2>&1; then
	export ATUIN_NOBIND=1
	eval "$(atuin init zsh)"
fi

if command -v fzf 2>&1 >/dev/null; then
	export FZF_DEFAULT_OPTS='--height=45% --min-height=18 --layout=reverse --border=rounded --info=inline-right --prompt="> " --pointer=">" --marker="*" --cycle --multi --scroll-off=3 --bind=ctrl-j:down --bind=ctrl-k:up --bind=ctrl-d:half-page-down --bind=ctrl-u:half-page-up --bind=ctrl-a:select-all --bind=ctrl-y:deselect-all'
	export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'

	export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
	export FZF_CTRL_T_OPTS='--scheme=path --preview "if [[ -d {} ]]; then tree -C {} | head -200; else bat --style=numbers --color=always --line-range :500 {}; fi" --bind "ctrl-/:change-preview-window(right,60%,border-left|down,40%,border-top|hidden|)"'

	export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
	export FZF_ALT_C_OPTS='--preview "tree -C {} | head -200"'

	export FZF_CTRL_R_OPTS='--scheme=history --bind "ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort" --header "CTRL-Y copies the selected command"'


	eval "$(fzf --zsh)"

	# Grep widget backed by ripgrep and fzf.
	fzf-grep-widget() {
		setopt localoptions pipefail no_aliases no_glob 2>/dev/null

		local rg_prefix selected ret
		local file rest line col
		local -a fzf_cmd

		cmd='rg --column --line-number --no-heading --color=always --smart-case'

		# Reuse fzf's native shell launcher so tmux users get fzf-tmux automatically.
		fzf_cmd=( ${(z)$(__fzfcmd)} )
		fzf_cmd+=(
			--ansi
			--disabled
			--delimiter ':'
			--query "$LBUFFER"
			--preview 'bat --terminal-width=$FZF_PREVIEW_COLUMNS --color=always --highlight-line {2} {1}'
			--preview-window 'bottom,60%,border-bottom,+{2}+3/3,~3'
			--bind "start:reload:$cmd \"\""
			--bind "change:reload:$cmd {q} || true"
			--bind 'ctrl-/:change-preview-window(up,60%,border-bottom,+{2}+3/3,~3|hidden|)'
		)

		selected="$(
			FZF_DEFAULT_OPTS_FILE='' "${fzf_cmd[@]}" < /dev/tty
		)"
		ret=$?

		if [[ -z "$selected" ]]; then
			zle redisplay
			return $ret
		fi

		file=${selected%%:*}
		rest=${selected#*:}
		line=${rest%%:*}
		rest=${rest#*:}
		col=${rest%%:*}

		# Execute the editor command like native widgets do with cd/history actions.
		zle push-line
		BUFFER="nvim +${line} -- ${(q)file}"
		zle accept-line
		zle reset-prompt
		return $ret
	}
	zle -N fzf-grep-widget
fi

if command -v sheldon >/dev/null 2>&1; then
	eval "$(sheldon source)"
fi

autoload -Uz compinit
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
compinit -d "${XDG_STATE_HOME}/zsh/zcompdump"

if command -v mise >/dev/null 2>&1; then
  export MISE_SHIMS_DIR="$XDG_DATA_HOME/mise/shims"
  # export MISE_ENV_FILE=.env
  eval "$(mise activate zsh)"
fi

if command -v zellij 2>&1 >/dev/null; then
	export ZELLIJ_AUTO_ATTACH=true
	export ZELLIJ_AUTO_EXIT=false
	eval "$(zellij setup --generate-auto-start zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.zsh" ]]; then
	source "$XDG_CONFIG_HOME/zsh/aliases.zsh"
fi

if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bindings.zsh" ]]; then
	source "$XDG_CONFIG_HOME/zsh/bindings.zsh"
fi

# vim: set ft=zsh
