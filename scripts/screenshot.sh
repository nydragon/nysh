#! /usr/bin/env bash

set -e

geometry="$1"
filename="$2"

grim -g "$geometry" "$filename"

wl-copy <"$filename"

(
    result="$(
        notify-send \
            --app-name Shell \
            --action "copy-path=Copy Path" \
            --action "copy-image=Copy Image" \
            --action "open-satty=Open in Satty" \
            "Screenshot taken" \
            "<img src=\"$filename\">"
    )"

    case "$result" in
    "copy-path")
        wl-copy "$filename"
        ;;
    "copy-image")
        wl-copy <"$filename"
        ;;
    "open-satty") satty --filename "$filename" ;;
    esac
) &
