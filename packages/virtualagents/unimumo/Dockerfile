#---
# name: unimumo
# group: virtualagents
# config: config.py
# depends: [pytorch, torchvision, torchaudio, transformers, huggingface_hub]
# requires: '>=34.1.0'
# test: test.py
# notes: https://github.com/state-spaces/unimumo
#---
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG unimumo_VERSION \
    CUDAARCHS

COPY install.sh /tmp/unimumo/

RUN /tmp/unimumo/install.sh

CMD ["/bin/bash"]
