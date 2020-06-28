#!/usr/bin/env bash

#Change to your local machine's architecture
KERNEL=$(uname -s)
if [ $KERNEL = "Darwin" ]; then
    DYNAMIC_LIB_EXTENTION=dylib
else
    DYNAMIC_LIB_EXTENTION=so
fi

build_host_platform () {
    cmake . -Bbuild_host -DSTAGE=$1 -DPROFILING=OFF -DCMAKE_BUILD_TYPE=$2
    cmake --build build_host --target all
    cmake --build build_host --target install
}

build_type=$1
if [ -z "$build_type" ]
then
      build_type="Release"
      echo "Selected build type $build_type"
else
      echo "Selected build type $build_type"
fi

build_host_platform 1 $build_type