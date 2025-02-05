# Enshrouded server scripts

Quick and dirty scripts to make backups, pull, and push world saves for enshrouded.

## Setup
- A linux host with [jsknnr/enshrouded-server](https://github.com/jsknnr/enshrouded-server) cloned into `/root/server/enshrouded-server`.
    - A small change, using the `enshrouded-persistent-data` directory instead of the volume.
    - `./enshrouded-persistent-data:/home/steam/enshrouded/savegame:rw` instead of `enshrouded-persistent-data:/home/steam/enshrouded/savegame`
- Docker user namespace remapping `root:10000:65535` (`/etc/subuid`) / `{ "userns-remap": "root" }` (`/etc/docker/daemon.json`)


## Configuration

For a Windows machine with WSL. See `common.sh`.
```
export ENSHROUDED_APPID=1203620
export STEAM_USERID=YOURID
export SAVEGAME_DIR="/mnt/c/Program Files (x86)/Steam/userdata/${STEAM_USERID}/${ENSHROUDED_APPID}/remote"

export SERVER_ROOT="/root/server/enshrouded-server/container"
export SERVER_DIR="${SERVER_ROOT}/enshrouded-persistent-data"

WORLD_ID=3ad85aea
```

## SSH access

These scripts expect a configuration for an SSH host named `enshrouded`.
**Note**: The server has no security hardening whatsoever, so everything is just running under the `root` user.

```
Host enshrouded
    HostName YOUR_SERVER_IP
    User root
    SetEnv TERM=screen-256color
    IdentityFile ~/.ssh/id_rsa
```


