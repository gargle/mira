# from https://github.com/devcontainers/images/blob/main/src/java-8/.devcontainer/Dockerfile
# [Choice] Debian OS version (use bullseye on local arm64/Apple Silicon): bookworm, buster, bullseye
ARG VARIANT="bookworm"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends ssh libdatetime-event-sunrise-perl
