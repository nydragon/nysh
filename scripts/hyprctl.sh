#! /usr/bin/env bash

set -e

echo -n "j/$1" | socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$2/.socket.sock"
