#!/bin/bash

case "$(uname)" in
Darwin)
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	;;
Linux) ;;
esac
