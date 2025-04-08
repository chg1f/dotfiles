#!/bin/bash

if [[ -x "$HOMEBREW_PREFIX/opt/tpm/share/tpm/bin/update_plugins" ]]; then
	"$HOMEBREW_PREFIX/opt/tpm/share/tpm/bin/update_plugins" all
fi
