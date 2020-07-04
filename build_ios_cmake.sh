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

if [ -d "3rdparty/opencv2.framework" ]; then
  echo "Used prebuilt libraries"
else
  echo "opencv2.framework folder does not exist, starting download and unpack it first"
  mkdir -p 3rdparty
  cd 3rdparty
  wget -q -O tmp.zip https://sourceforge.net/projects/opencvlibrary/files/4.3.0/opencv-4.3.0-ios-framework.zip/download && unzip tmp.zip && rm tmp.zip
  cd ..
fi

mkdir -p ios/include
ln -s ../../3rdparty/opencv2.framework/Headers ios/include/opencv2

build_all_platforms 1 $1

cd ./patchmatch-ios
./build_framework.sh $1
cd ..