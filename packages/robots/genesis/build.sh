#!/usr/bin/env bash
set -ex

wget https://apt.llvm.org/llvm.sh
chmod u+x llvm.sh
./llvm.sh 18 all
ln -sf /usr/bin/llvm-config-* /usr/bin/llvm-config
ln -s /usr/bin/clang-1* /usr/bin/clang

echo "Setting up environment for genesis ${GENESIS_VERSION}"

echo "Building genesis ${GENESIS_VERSION}"
git clone --recursive https://github.com/taichi-dev/taichi /opt/taichi/

cd /opt/taichi/

# Customize with your own needs
export TAICHI_CMAKE_ARGS="-DTI_WITH_VULKAN:BOOL=ON -DTI_WITH_CUDA:BOOL=ON"
./build.py --python=native

# Clone the repository if it doesn't exist
git clone --branch=v${GENESIS_VERSION} --depth=1 --recursive https://github.com/Genesis-Embodied-AI/Genesis /opt/genesis || \
git clone --depth=1 --recursive https://github.com/Genesis-Embodied-AI/Genesis /opt/genesis

cd /opt/genesis

pip3 install git+https://github.com/taichi-dev/taichi.git --verbose
pip3 wheel . -w /opt/genesis/wheels --verbose

pip3 install --no-cache-dir --verbose /opt/genesis/wheels/genesis-world*.whl

twine upload --verbose /opt/genesis/wheels/genesis-world*.whl || echo "failed to upload wheel to ${TWINE_REPOSITORY_URL}"

echo "genesis OK\n"

