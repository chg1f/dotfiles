#!/bin/bash

if command -v zimfw >/dev/null 2>&1; then
	# zimfw update
	# zimfw self-update
	zsh -c 'zimfw update'
fi
