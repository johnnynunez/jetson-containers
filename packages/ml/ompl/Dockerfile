# ---
# name: ompl
# group: ml
# config: config.py
# depends: [python, ninja, cmake, numpy]
# requires: '>=34.1.0'
# test: test.py
# notes: https://github.com/state-spaces/ompl
# ---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG OMPL_VERSION \
    CUDAARCHS

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    libatlas-base-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    libhdf5-dev \
    libcgal-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libgflags-dev \
    libglew-dev \
    libgoogle-glog-dev \
    libmetis-dev \
    libprotobuf-dev \
    libqt5opengl5-dev \
    libsqlite3-dev \
    libsuitesparse-dev \
    nano \
    protobuf-compiler \
    libgtest-dev \
    qtbase5-dev \
    sudo \
    vim-tiny \
    wget && \
    rm -rf /var/lib/apt/lists/* \

# Copy build and install scripts
COPY build.sh install.sh /tmp/ompl/

# Execute the install script, fallback to build if install fails
RUN /tmp/ompl/install.sh || /tmp/ompl/build.sh
