#---
# name: genesis
# group: robots
# config: config.py
# depends: [rust, cmake, pytorch, torchvision, torchaudio, pymeshlab, openexr, ompl]
# requires: '>=34.1.0'
# notes: https://github.com/Genesis-Embodied-AI/Genesis.git
#---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG GENESIS_VERSION \
    FORCE_BUILD=off

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libglfw3-dev \
    libglm-dev \
    liblz4-dev \
    libssl-dev \
    libtinfo-dev \
    libwayland-dev \
    libx11-xcb-dev \
    libxcb-dri3-dev \
    libxcb-ewmh-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libzstd-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY build.sh install.sh /tmp/GENESIS/

RUN /tmp/GENESIS/install.sh || /tmp/GENESIS/build.sh

