#! /usr/bin/env bash

while read -r line; do
    if cliphist decode "$line" | wl-copy; then
        echo "$line"
    fi
done
