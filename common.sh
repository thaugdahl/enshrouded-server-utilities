export ENSHROUDED_APPID=1203620
export STEAM_USERID=$(cat userid)
export SAVEGAME_DIR="/mnt/c/Program Files (x86)/Steam/userdata/${STEAM_USERID}/${ENSHROUDED_APPID}/remote"

export SERVER_ROOT="/root/server/enshrouded-server/container"
export SERVER_DIR="${SERVER_ROOT}/enshrouded-persistent-data"

WORLD_ID=3ad85aea

BACKUPDIR="$(date +%Y%m%d-%H%M%S)"

setup_directories() {
    mkdir -p local
    mkdir -p remote
}

pull_files() {
    BACKUPDIR=$1
    rsync -avz enshrouded:${SERVER_DIR}/${WORLD_ID}* remote/${BACKUPDIR}
}

push_files() {
    BACKUPDIR=$1
    rsync -avz  ${BACKUPDIR}/${WORLD_ID}* enshrouded:${SERVER_DIR}/
}

backup_remote() {
    BACKUPDIR=$1
    BACKUPDIR="$(date +%Y%m%d-%H%M%S)"
    pull_files ${BACKUPDIR}
    tar -czf remote/${BACKUPDIR}.tgz remote/${BACKUPDIR}

    echo remote/${BACKUPDIR}
}


backup_local() {
    # Backup local
    BACKUPDIR=$1
    mkdir local/${BACKUPDIR}
    cp "${SAVEGAME_DIR}"/* local/${BACKUPDIR}
    tar -czf local/${BACKUPDIR}.tgz local/${BACKUPDIR}

    echo local/${BACKUPDIR}
}

get_last_backup() {
    case $1 in
        "local" | "remote")
            ;;
        *)
            return ;;
    esac

    ls -datr1 $1/*/ | tail -n 1
}

copy_to_steam() {
    LAST_BACKUP=$(get_last_backup remote)
    cp remote/${LAST_BACKUP}/* "${SAVEGAME_DIR}"
}

stop_server() {
    ssh enshrouded "cd ${SERVER_ROOT} && docker compose stop"
}

setup_permissions() {
    ssh enshrouded "sudo chown -R 10000:10000 ${SERVER_DIR}"
}

start_server() {
    ssh enshrouded "cd ${SERVER_ROOT} && docker compose up -d"
}

get_server_ip() {
    ssh enshrouded "curl -s ifconfig.me && echo "
}
