#!/usr/bin/env bash
set -ex

wget https://apt.llvm.org/llvm.sh
chmod u+x llvm.sh
./llvm.sh 18 all

# Clone the repository if it doesn't exist
wget https://ompl.kavrakilab.org/install-ompl-ubuntu.sh
chmod u+x install-ompl-ubuntu.sh
./install-ompl-ubuntu.sh -g -p


pip3 install 'numpy<2'

# Optionally upload to a repository using Twine
twine upload --verbose /opt/ompl/wheels/ompl*.whl || echo "Failed to upload wheel to ${TWINE_REPOSITORY_URL}"
