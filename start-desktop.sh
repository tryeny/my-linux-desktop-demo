#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
display=:1
user_id=$(id -u)
browser=$(command -v firefox || command -v firefox-esr || true)

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

mkdir -p "$HOME/.fluxbox"
if [[ -f "$script_dir/.devcontainer/fluxbox-startup" ]]; then
    cp "$script_dir/.devcontainer/fluxbox-startup" "$HOME/.fluxbox/startup"
    chmod 755 "$HOME/.fluxbox/startup"
fi

if [[ ! -f "$HOME/.fluxbox/menu" ]]; then
    cat > "$HOME/.fluxbox/menu" <<EOF
[begin] (Desktop)
[exec] (Terminal) { xterm }
[exec] (Firefox) { ${browser:-firefox} }
[separator]
[submenu] (System)
  [exec] (Reconfigure) { fluxbox -reset }
  [exec] (Restart) { fluxbox -restart }
[end]
[end]
EOF
fi

if [[ ! -f "$HOME/.fluxbox/init" ]]; then
    cat > "$HOME/.fluxbox/init" <<'EOF'
session.screen0.menuDelay: 200
session.screen0.workspacewarping: false
session.screen0.maxOverdraw: 500
EOF
fi

if ! pgrep -u "$user_id" -x xfdesktop > /dev/null 2>&1; then
    DISPLAY="$display" xfdesktop > /tmp/xfdesktop.log 2>&1 &
fi

if command -v xfce4-panel > /dev/null 2>&1 && ! pgrep -u "$user_id" -x xfce4-panel > /dev/null 2>&1; then
    DISPLAY="$display" xfce4-panel > /tmp/xfce4-panel.log 2>&1 &
fi

if [[ -n "$browser" ]] && ! pgrep -u "$user_id" -f '[/]firefox(-esr)?([[:space:]]|$)' > /dev/null 2>&1; then
    DISPLAY="$display" "$browser" --no-remote \
        > /tmp/firefox.log 2>&1 &
fi
