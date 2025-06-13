#! /usr/bin/env bash

geometry="$1"
filename="$2"

grim -g "$geometry" "$filename"

wl-copy <"$filename"
