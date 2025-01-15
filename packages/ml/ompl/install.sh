#!/usr/bin/env bash
set -ex

wget https://apt.llvm.org/llvm.sh
chmod u+x llvm.sh
./llvm.sh 18 all

if [ "$FORCE_BUILD" == "on" ]; then
	echo "Forcing build of ompl ${OMPL}"
	exit 1
fi

pip3 install --no-cache-dir --verbose ompl==${OMPL_VERSION}