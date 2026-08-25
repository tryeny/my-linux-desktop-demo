#!/usr/bin/env bash

set -euo pipefail

display=:1
vnc_port=5901
novnc_port=6080
user_id=$(id -u)

if ! pgrep -x Xtightvnc > /dev/null 2>&1; then
    killall -q vncserver Xtightvnc 2>/dev/null || true
    rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
    vncserver "$display" -geometry 1280x720 -depth 24
fi

if ! ss -H -ltn "sport = :$novnc_port" | grep -q .; then
    websockify --web=/usr/share/novnc/ "$novnc_port" "localhost:$vnc_port" \
        > /tmp/websockify.log 2>&1 &
fi

if ! pgrep -u "$user_id" -f '[s]tartxfce4|[x]fce4-session' > /dev/null 2>&1; then
    DISPLAY="$display" XAUTHORITY="$HOME/.Xauthority" startxfce4 \
        > /tmp/xfce4.log 2>&1 &
fi
