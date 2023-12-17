#!/usr/bin/env bash

echo "Running zkApp.exe ..."

ABS_REPO_PATH=$(git rev-parse --show-toplevel)

APP="${ABS_REPO_PATH}/build/apps/zkApp"

os_platform=$(uname -s)

# Boost dependencies
# change BOOST_ROOT to root folder of your boost installation
# if you built and left Boost in $HOME/dev/boost_1_83_0, set it to that
# BOOST_ROOT=${HOME}/dev/boost_1_83_0
# BOOST_LIB=${BOOST_ROOT}/stage/lib
BOOST_ROOT=/usr/local
BOOST_LIB=${BOOST_ROOT}/lib
LIBPATH=${BOOST_LIB}

# zookeeper-cpp dependencies
ZKCPP=${ABS_REPO_PATH}/zookeeper-cpp/src
ZKCPPBUILD=${ABS_REPO_PATH}/zookeeper-cpp.build
ZKCPPLIB=${ZKCPPBUILD}
LIBPATH=${LIBPATH}:${ZKCPPLIB}

# served dependencies
SERVED_ROOT=${ABS_REPO_PATH}/served.build/build/libserved-1.4.3-Linux
SERVED_LIB=${SERVED_ROOT}/lib
LIBPATH=${LIBPATH}:${SERVED_LIB}

case "${os_platform}" in
	Darwin*)
		OS=Mac
		DYLD_LIBRARY_PATH=${LIBPATH}:${DYLD_LIBRARY_PATH} gdb ${APP};;
	Linux*)
		OS=Linux
		LD_LIBRARY_PATH=${LIBPATH}:${LD_LIBRARY_PATH} gdb ${APP};;
	*)	
		OS=Unknown
		echo "Don't know how to run on your ${OS}.";;
esac

echo "Done."
