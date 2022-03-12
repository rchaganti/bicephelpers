FROM mcr.microsoft.com/azure-cli:latest
LABEL maintainer="ravikanth@ravichaganti.com"

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN curl -Lo bicep.bin https://github.com/Azure/bicep/releases/latest/download/bicep-linux-musl-x64 \
 && chmod +x ./bicep.bin \
 && mv ./bicep.bin /usr/local/bin/bicep
