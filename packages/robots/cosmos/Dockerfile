#--- 
# name: cosmos
# group: diffusion
# depends: [pytorch, torchvision, torchaudio, transformer-engine, transformers, opencv:4.11.0, bitsandbytes, huggingface_hub, ffmpeg]
# requires: '>=34.1.0'
# docs: docs.md
#---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /opt

RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/NVIDIA/Cosmos && \
    cd Cosmos && \
    pip3 install --no-cache-dir einops attrs pynvml opencv-contrib-python protobuf && \
    pip3 install --no-cache-dir -r requirements.txt

WORKDIR /opt/Cosmos/
CMD ["/bin/bash"]