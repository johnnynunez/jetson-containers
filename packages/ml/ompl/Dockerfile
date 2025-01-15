#---
# name: ompl
# group: ml
# config: config.py
# depends: [python, ninja, cmake, numpy]
# requires: '>=34.1.0'
# test: test.py
#---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG OMPL_VERSION \
FORCE_BUILD=off

ARG CUDAARCHS

ENV DEBIAN_FRONTEND=noninteractive

COPY build.sh install.sh /tmp/OMPL/
RUN pip3 install build wheel pygccxml
WORKDIR /opt/

RUN /tmp/OMPL/install.sh || /tmp/OMPL/build.sh
