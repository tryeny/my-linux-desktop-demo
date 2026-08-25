#!/bin/bash

if ! pgrep -x Xtightvnc > /dev/null 2>&1; then
    killall -q vncserver Xtightvnc 2>/dev/null || true
    rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
    vncserver :1 -geometry 1280x720 -depth 24
fi

if ! pgrep -f 'websockify.*6080' > /dev/null 2>&1; then
    websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
fi
