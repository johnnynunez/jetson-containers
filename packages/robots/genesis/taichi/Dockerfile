#---
# name: taichi
# group: genesis
# config: config.py
# depends: [ninja, cmake, rust]
# requires: '>=34.1.0'
# test: test.py
# notes: https://github.com/taichi-dev/taichi
#---
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG TAICHI_VERSION

COPY build.sh install.sh /tmp/TAICHI/

RUN /tmp/TAICHI/install.sh || /tmp/TAICHI/build.sh
