# shellcheck shell=bash

if [ "$(tty)" = "/dev/tty1" ]; then
	export WLR_RENDERER_ALLOW_SOFTWARE=1
	exec sway
fi
