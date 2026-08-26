FROM mcr.microsoft.com/devcontainers/base:bookworm

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends firefox-esr \
    && rm -rf /var/lib/apt/lists/*