#!/usr/bin/env bash

CMD_NAME="node-server"
# check if running
ps aux|egrep ${CMD_NAME} | egrep -v grep

# kill it
PIDS=$(ps aux|egrep ${CMD_NAME} | egrep -v grep | awk '{print $2}')
if [ -z "$var" ]
then
      echo "No ${CMD_NAME} running."
else
    for pid in $PIDS
    do
        echo "Killing ${CMD_NAME} with pid ${pid}"
        kill -9 ${pid}
    done
fi
