#!/bin/bash
# shellcheck shell=bash source=/dev/null

[[ -r "$HOME/.profile" ]] && source "$HOME/.profile"
[[ -r "$HOME/.bash_login" ]] && source "$HOME/.bash_login"
[[ -r "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
