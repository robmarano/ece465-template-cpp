#!/usr/bin/env bash

echo "Running threaded-server ..."

os_platform=$(uname -s)
BOOST_ROOT=/usr/local
BOOST_LIB=${BOOST_ROOT}/lib
LIBPATH=${BOOST_LIB}

LOG="server.log"

case "${os_platform}" in
	Darwin*)
		OS=Mac
		DYLD_LIBRARY_PATH=${LIBPATH}:${DYLD_LIBRARY_PATH} ./build/apps/threaded-server 2>&1 > ${LOG} &
		echo "Server running in background. Check ${LOG}";;
	Linux*)
		OS=Linux
		LD_LIBRARY_PATH=${LIBPATH}:${LD_LIBRARY_PATH} ./build/apps/threaded-server 2>&1 > ${LOG} &
		echo "Server running in background. Check ${LOG}";;
	*)	
		OS=Unknown
		echo "Don't know how to run on your ${OS}.";;
esac

echo "Done. Don't forget to remove ${LOG}."
