#!/usr/bin/env bash
set -ex

wget https://apt.llvm.org/llvm.sh
chmod u+x llvm.sh
./llvm.sh 18 all
ln -sf /usr/bin/llvm-config-* /usr/bin/llvm-config
ln -s /usr/bin/clang-1* /usr/bin/clang

if [ "$FORCE_BUILD" == "on" ]; then
	echo "Forcing build of genesis ${GENESIS}"
	exit 1
fi

pip3 install --no-cache-dir --verbose genesis-world==${GENESIS_VERSION}