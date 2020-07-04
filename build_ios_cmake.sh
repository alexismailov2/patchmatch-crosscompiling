#!/usr/bin/env bash

build_selected_platform () {
cmake . -Bbuild_ios/$1 -G Xcode \
    -DCMAKE_TOOLCHAIN_FILE=ios-cmake/ios.toolchain.cmake \
    -DPLATFORM=$1 \
    -DSTAGE=$2 \
    -DCMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM=$3 \
    -DSTATIC_LIB=ON \
    -DARCHS="armv7 armv7s arm64"
cmake --build build_ios/$1 --config Release --target install
}

build_all_platforms() {
    build_selected_platform "OS" $1 $2
    #build_selected_platform "OS64COMBINED" $1 $2
}

mkdir -p ios/include
ln -s ../../3rdparty/opencv2.framework/Headers ios/include/opencv2

build_all_platforms 1 $1

cd ./patchmatch-ios
./build_framework.sh $1
cd ..