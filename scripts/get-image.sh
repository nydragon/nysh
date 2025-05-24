#! /usr/bin/env bash

while read -r line; do
    if [[ ! -f "/tmp/$line" ]]; then
        cliphist decode "$line" >"/tmp/$line"
    fi
    echo "$line"
done
