#!/bin/bash
# vim: set ts=4 sw=4 noet fileencoding=utf-8:

COMPILE_CORES=24

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=/Users/$user/lib:/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
export PATH=$DYLD_LIBRARY_PATH:$PATH

echo "Building..."
bazel build --jobs=$COMPILE_CORES --config=cuda --config=opt \
	--action_env PATH \
	--action_env LD_LIBRARY_PATH \
	--action_env DYLD_LIBRARY_PATH \
	//tensorflow/tools/pip_package:build_pip_package

if [[ $? == 0 ]]; then
	echo "Making wheel..."
	bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
fi
