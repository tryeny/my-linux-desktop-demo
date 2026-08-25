#!/bin/bash

if pgrep -x Xtightvnc > /dev/null 2>&1; then
    exit 0
fi

killall -q vncserver Xtightvnc websockify 2>/dev/null || true
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1
vncserver :1 -geometry 1280x720 -depth 24
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
