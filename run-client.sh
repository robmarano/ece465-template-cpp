#!/usr/bin/env bash

echo "Running threaded-client ..."

os_platform=$(uname -s)
BOOST_ROOT=/usr/local
BOOST_LIB=${BOOST_ROOT}/lib
LIBPATH=${BOOST_LIB}

case "${os_platform}" in
	Darwin*)
		OS=Mac
		DYLD_LIBRARY_PATH=${LIBPATH}:${DYLD_LIBRARY_PATH} ./build/apps/threaded-client;;
	Linux*)
		OS=Linux
		LD_LIBRARY_PATH=${LIBPATH}:${LD_LIBRARY_PATH} ./build/apps/threaded-client;;
	*)	
		OS=Unknown
		echo "Don't know how to run on your ${OS}.";;
esac

echo "Done."
