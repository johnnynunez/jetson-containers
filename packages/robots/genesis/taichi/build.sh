#!/usr/bin/env bash
set -ex

# Clone the repository if it doesn't exist
git clone --branch=v${TAICHI_VERSION} --depth=1 --recursive https://github.com/johnnynunez/taichi /opt/taichi  || \
git clone --depth=1 --recursive https://github.com/johnnynunez/taichi  /opt/taichi

# Navigate to the Taichi repository directory
cd /opt/taichi

# Download the LLVM installer script and make it executable
wget -q https://apt.llvm.org/llvm.sh
chmod +x llvm.sh

# Create a temporary APT configuration file to force overwrites of conflicting files.
# This tells dpkg to use the "--force-overwrite" option for all apt-get install actions.
echo 'Dpkg::Options {"--force-overwrite";};' > /etc/apt/apt.conf.d/99_force_overwrite

# Run the LLVM installer to install LLVM 15 (with all components)
./llvm.sh 15 all

# (Optional) Remove the temporary APT configuration file if you wish
rm /etc/apt/apt.conf.d/99_force_overwrite

# Create a symbolic link for llvm-config to point to the LLVM 15 version
ln -sf /usr/bin/llvm-config-* /usr/bin/llvm-config

# Set environment variables for the build
export MAX_JOBS=$(nproc)
export TAICHI_CMAKE_ARGS="-DTI_WITH_VULKAN:BOOL=ON -DTI_WITH_CUDA:BOOL=ON -DTI_CUDA_ARCHS=${CUDAARCHS}"
export CC=/usr/lib/llvm-15/bin/clang
export CXX=/usr/lib/llvm-15/bin/clang++

# Build Taichi
./build.py

# List the generated wheel file(s)
ls dist/*.whl

# Install the built wheel
pip3 install --no-cache-dir --verbose /opt/taichi/dist/*.whl

# Change directory to /opt/taichi (if not already there) and install numpy
cd /opt/taichi
pip3 install 'numpy<2'

# Optionally, upload the wheel using Twine (if configured)
twine upload --verbose /opt/taichi/dist/*.whl || echo "Failed to upload wheel to ${TWINE_REPOSITORY_URL}"