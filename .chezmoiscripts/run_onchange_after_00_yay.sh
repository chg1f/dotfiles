#!/bin/bash

if command -v yay >/dev/null 2>&1; then
	yay -S --needed - <"$HOME/.config/yay/pkglist.txt" && yay -Yc
fi
