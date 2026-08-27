FROM mcr.microsoft.com/devcontainers/base:bookworm

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends firefox-esr xfdesktop4 xfce4-appfinder xfce4-panel xfce4-terminal \
    && rm -rf /var/lib/apt/lists/*

COPY fluxbox-startup /home/vscode/.fluxbox/startup
RUN chown vscode:vscode /home/vscode/.fluxbox/startup \
    && chmod 755 /home/vscode/.fluxbox/startup