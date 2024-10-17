#!/usr/bin/env bash
set -ex

# Clone the repository if it doesn't exist
git clone --depth=1 --recursive https://github.com/hanyangclarence/UniMuMo /opt/unimumo

cd /opt/unimumo 

pip3 install -r requirements.txt
pip3 install madmom==0.16.1
pip3 install 'numpy<2'