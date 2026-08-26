#!/usr/bin/env bash

set -euo pipefail

display=:1
user_id=$(id -u)
browser=$(command -v firefox || command -v firefox-esr || true)

if [[ -z "$browser" ]] && command -v curl > /dev/null 2>&1 && command -v tar > /dev/null 2>&1; then
    firefox_dir="$HOME/.local/firefox"
    mkdir -p "$HOME/.local"
    if [[ ! -x "$firefox_dir/firefox" ]]; then
        curl --fail --location --retry 3 --connect-timeout 10 \
            'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' \
            --output "$HOME/.local/firefox.tar.bz2" \
            && rm -rf "$firefox_dir" \
            && tar -xjf "$HOME/.local/firefox.tar.bz2" -C "$HOME/.local" \
            && rm -f "$HOME/.local/firefox.tar.bz2" \
            || rm -f "$HOME/.local/firefox.tar.bz2"
    fi
    [[ -x "$firefox_dir/firefox" ]] && browser="$firefox_dir/firefox"
fi

for _ in {1..30}; do
    if DISPLAY="$display" xdpyinfo > /dev/null 2>&1; then
        break
    fi
    sleep 1
done

if ! DISPLAY="$display" xdpyinfo > /dev/null 2>&1; then
    echo "Desktop display $display is not available" >&2
    exit 1
fi

if ! pgrep -u "$user_id" -f '[/]xterm([[:space:]]|$)' > /dev/null 2>&1; then
    DISPLAY="$display" xterm -geometry 100x28+24+24 -title "Desktop Terminal" \
        > /tmp/desktop-terminal.log 2>&1 &
fi

if [[ -n "$browser" ]] && ! pgrep -u "$user_id" -f '[/]firefox(-esr)?([[:space:]]|$)' > /dev/null 2>&1; then
    DISPLAY="$display" "$browser" --no-remote \
        > /tmp/firefox.log 2>&1 &
fi
