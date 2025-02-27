#!/bin/bash

case "$(uname -s)" in
Darwin)
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	;;
Linux) ;;
*) ;;
esac
