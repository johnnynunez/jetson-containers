#!/usr/bin/env bash
set -ex

# Clone the repository if it doesn't exist
git clone --branch=v${TAICHI_VERSION} --depth=1 --recursive https://github.com/johnnynunez/taichi /opt/taichi  || \
git clone --depth=1 --recursive https://github.com/johnnynunez/taichi  /opt/taichi

# Navigate to the directory containing mamba's setup.py
cd /opt/taichi  

export MAX_JOBS=$(nproc)
export TAICHI_CMAKE_ARGS="-DTI_WITH_VULKAN:BOOL=ON -DTI_WITH_CUDA:BOOL=ON"
./build.py
ls dist/*.whl
pip3 install --no-cache-dir --verbose /opt/taichi/dist/*.whl

cd /opt/taichi

pip3 install 'numpy<2'

# Optionally upload to a repository using Twine
twine upload --verbose /opt/taichi/dist/*.whl || echo "Failed to upload wheel to ${TWINE_REPOSITORY_URL}"
