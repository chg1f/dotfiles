#!/bin/bash

if command -v brew >/dev/null 2>&1; then
	brew update
	brew upgrade
fi
