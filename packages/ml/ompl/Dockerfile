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

# Copy build and install scripts
COPY build.sh install.sh /tmp/ompl/

# Execute the install script, fallback to build if install fails
RUN /tmp/ompl/install.sh || /tmp/ompl/build.sh
