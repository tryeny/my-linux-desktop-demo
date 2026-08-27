# My Linux Desktop

Run a lightweight Linux desktop in GitHub Codespaces and open it in your
browser through noVNC.

## Launch the public Codespace

[Create a Codespace](https://github.com/codespaces/new?repo=tryeny/my-linux-desktop-demo)

After the Codespace finishes creating, open the forwarded **Linux Desktop**
port (`6080`) from the Ports panel. Codespaces opens the browser automatically
and loads noVNC at `/vnc.html`. The desktop starts automatically when the
container starts. Use `vscode` as the VNC password.

## Local container setup

This repository includes a `.devcontainer/devcontainer.json` configuration.
Open the repository in GitHub Codespaces or in VS Code with the Dev Containers
extension to use it.
