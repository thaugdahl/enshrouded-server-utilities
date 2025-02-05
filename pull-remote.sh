#!/bin/bash


source common.sh
setup_directories

BACKUPDIR="$(date +%Y%m%d-%H%M%S)"

REMOTE_BACKUP=$(backup_remote $BACKUPDIR)
LOCAL_BACKUP=$(backup_local ${BACKUPDIR}-pull)

copy_to_steam

