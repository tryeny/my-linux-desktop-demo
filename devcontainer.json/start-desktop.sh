
  "name": "My Linux Desktop",
  "image": "mcr.microsoft.com/devcontainers/universal:2",
  "features": {
    "ghcr.io/devcontainers/features/desktop-lite:1": {}
  },
  "postCreateCommand": "install -m 0755 start-desktop.sh \"$HOME/start-desktop.sh\"",
  "postStartCommand": "$HOME/start-desktop.sh",
  "forwardPorts": [6080],
  "portsAttributes": {
    "6080": {
      "label": "Linux Desktop"
    }
  }
}
