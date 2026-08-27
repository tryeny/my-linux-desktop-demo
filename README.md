# My Linux Desktop

Run a lightweight Linux desktop in GitHub Codespaces and open it in your
browser through noVNC.

## Launch the public Codespace

[Create a Codespace](https://github.com/codespaces/new?repo=tryeny/my-linux-desktop-demo)

After the Codespace finishes creating, open the forwarded **Linux Desktop**
port (`6080`) from the Ports panel. Codespaces opens the browser automatically
and loads noVNC at `/vnc.html`. The desktop starts automatically when the
container starts. Use `vscode` as the VNC password.

If noVNC shows the connection screen, click **Connect** and enter `vscode` in
the password prompt. The VNC password is case-sensitive.

The desktop is configured for a Chromebook-sized browser viewport. New
Codespaces request 64 GB of storage; recreate an existing Codespace to apply
that request. Roblox is not supported in this Linux desktop, so use the
official ChromeOS/Android Roblox app on a Chromebook.

## Local container setup

This repository includes a `.devcontainer/devcontainer.json` configuration.
Open the repository in GitHub Codespaces or in VS Code with the Dev Containers
extension to use it.
