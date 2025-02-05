#!/bin/bash


source common.sh
setup_directories

BACKUPDIR="$(date +%Y%m%d-%H%M%S)"

TARGET_DIR=$(get_last_backup local)

echo $TARGET_DIR

REMOTE_BACKUP=$(backup_remote ${BACKUPDIR}-push)
LOCAL_BACKUP=$(backup_local ${BACKUPDIR})

stop_server
push_files ${LOCAL_BACKUP}
setup_permissions
start_server


