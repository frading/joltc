#!/bin/sh

if [ -z $1 ]
then
	BUILD_TYPE=Debug
else
	BUILD_TYPE=$1
	shift
fi

BUILD_DIR=NATIVE_SHARED_$BUILD_TYPE

echo Usage: ./cmake_linux_native.sh [Configuration]
echo "Possible configurations: Debug (default), Release, Distribution"
echo Generating Makefile for build type \"$BUILD_TYPE\" in folder \"$BUILD_DIR\"

cmake -S "./../" --log-level=VERBOSE -B $BUILD_DIR -G "Unix Makefiles" -DJPH_BUILD_SHARED=1 -DCMAKE_BUILD_TYPE=$BUILD_TYPE "${@}"

echo Compile by running \"make -j $(nproc)\" in folder \"$BUILD_DIR\"