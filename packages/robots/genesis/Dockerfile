#---
# name: genesis
# group: robots
# config: config.py
# depends: [rust, cmake, torch, torchvision, torchaudio]
# requires: '>=36.0.0'
# test: test.py
# notes: https://github.com/Genesis-Embodied-AI/Genesis.git
#---

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG GENESIS_VERSION \
FORCE_BUILD=off

ARG CUDAARCHS

ENV DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.10

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    manpages-dev \
    libvulkan-dev \
    zlib1g-dev \
    xorg-dev libglu1-mesa-dev \
    libsnappy-dev \
    software-properties-common \
    git \
    curl \
    wget \
    gcc-11 \
    g++-11 \
    patchelf && \
    rm -rf /var/lib/apt/lists/*

RUN pip install "pybind11[global]"

# Build LuisaRender
WORKDIR /workspace
RUN git clone --recursive https://github.com/Genesis-Embodied-AI/Genesis /opt/genesis && \
    cd /opt/genesis
COPY build_luisa.sh /workspace/build_luisa.sh
RUN chmod +x ./build_luisa.sh && ./build_luisa.sh ${PYTHON_VERSION}

# ===============================================================
# Stage 2: Runtime Environment
# ===============================================================

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    tmux \
    git \
    curl \
    wget \
    bash-completion \
    libgl1 \
    libgl1-mesa-glx \
    libegl-dev \
    libegl1 \
    libxrender1 \
    libglib2.0-0 \
    ffmpeg \
    libgtk2.0-dev \
    pkg-config \
    libvulkan-dev \
    libgles2 \
    libglvnd0 \
    libglx0 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# --------------------------- Genesis ----------------------------
RUN pip3 install --no-cache-dir open3d && \
cd /opt/genesis && \
pip3 install . && \
pip3 install --no-cache-dir PyOpenGL==3.1.5

# ------------------------ Motion planning -----------------------
RUN PYTHON_MAJOR_MINOR=$(echo ${PYTHON_VERSION} | tr -d '.') && \
    wget https://github.com/johnnynunez/ompl/releases/download/prerelease/ompl-1.6.0-cp${PYTHON_MAJOR_MINOR}-cp${PYTHON_MAJOR_MINOR}-manylinux_2_28_aarch64.whl && \
    pip install ompl-1.6.0-cp${PYTHON_MAJOR_MINOR}-cp${PYTHON_MAJOR_MINOR}-manylinux_2_28_aarch64.whl && \
    rm ompl-1.6.0-cp${PYTHON_MAJOR_MINOR}-cp${PYTHON_MAJOR_MINOR}-manylinux_2_28_aarch64.whl

# -------------------- Surface Reconstruction --------------------
# Set the LD_LIBRARY_PATH directly in the environment
COPY --from=builder /workspace/Genesis/genesis/ext/ParticleMesher/ParticleMesherPy /usr/local/lib/python3.10/site-packages/genesis/ext/ParticleMesher/ParticleMesherPy
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.10/site-packages/genesis/ext/ParticleMesher/ParticleMesherPy:$LD_LIBRARY_PATH

# --------------------- Ray Tracing Renderer ---------------------
# Copy LuisaRender build artifacts from the builder stage
COPY --from=builder /workspace/Genesis/genesis/ext/LuisaRender/build/bin /usr/local/lib/python3.10/site-packages/genesis/ext/LuisaRender/build/bin

ENTRYPOINT ["/bin/bash"]
