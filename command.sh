#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Give command"
    echo "local | remote | pull | push"
fi

source common.sh
setup_directories

case $1 in
    "local")
        backup_local ${BACKUPDIR};;
    "remote")
        backup_remote ${BACKUPDIR};;
    "pull")
        source pull-remote.sh ;;
    "push")
        source push-remote.sh ;;
    "ip")
        get_server_ip ;;
esac
