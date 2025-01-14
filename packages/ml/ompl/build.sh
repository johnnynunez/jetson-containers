#!/usr/bin/env bash
set -ex

# Clone the repository if it doesn't exist
git clone --branch=v${OMPL_VERSION} --depth=1 --recursive https://github.com/ompl/ompl /opt/ompl || \
git clone --depth=1 --recursive https://github.com/ompl/ompl /opt/ompl

# Navigate to the directory containing ompl's setup.py
cd /opt/ompl 

pip3 install 'numpy<2' pyplusplus pygccxml
pip3 install 'numpy<2'

export MAX_JOBS=$(nproc)
mkdir -p build/Release
cd build/Release
cmake ../..
# next step is optional
make -j ${MAX_JOBS} update_bindings # if you want Python bindings
make -j ${MAX_JOBS}
make install
pip3 wheel --no-build-isolation --wheel-dir=/opt/ompl/wheels .
pip3 install --no-cache-dir --verbose /opt/ompl/wheels/ompl_ssm*.whl

cd /opt/ompl
pip3 install 'numpy<2'

# Optionally upload to a repository using Twine
twine upload --verbose /opt/ompl/wheels/ompl_ssm*.whl || echo "Failed to upload wheel to ${TWINE_REPOSITORY_URL}"
