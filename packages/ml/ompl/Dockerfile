#---
# name: ompl
# group: ml
# config: config.py
# depends: [cmake]
# requires: '>=34.1.0'
# test: test.py
# notes: https://github.com/state-spaces/ompl
#---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG OMPL_VERSION \
    CUDAARCHS

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libompl-dev \
        g++ \
        cmake \
        pkg-config \
        libboost-serialization-dev \
        libboost-filesystem-dev \
        libboost-system-dev \
        libboost-program-options-dev \
        libboost-test-dev \
        libeigen3-dev \
        libode-dev \
        wget \
        libyaml-cpp-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY build.sh install.sh /tmp/ompl/

RUN /tmp/ompl/install.sh || /tmp/ompl/build.sh