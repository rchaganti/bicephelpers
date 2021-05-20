FROM mcr.microsoft.com/azure-cli:latest
LABEL maintainer="ravikanth@ravichaganti.com"

RUN curl -Lo bicep.bin https://github.com/Azure/bicep/releases/latest/download/bicep-linux-musl-x64
RUN chmod +x ./bicep.bin
RUN mv ./bicep.bin /usr/local/bin/bicep
