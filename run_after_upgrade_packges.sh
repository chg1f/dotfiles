#!/bin/bash

if command -v brew >/dev/null 2>&1; then
	brew update && brew bundle
	# brew update && brew upgrade
fi
if command -v nvim >/dev/null 2>&1; then
	nvim --headless "+Lazy! sync" +qa
fi
if command -v fisher >/dev/null 2>&1; then
	fisher update
fi
