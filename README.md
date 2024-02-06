# Build args:
|Variable       | Utility                                         |
|---------------|-------------------------------------------------|
|STEAM_LOGIN    | set the steam login to retrive the server files |
|STEAM_PASS     | set the steam password                          |
|STEAM_GUARD    | steam guard code (from your phone)              |

# Environements variables
|Variable         | Utility                                                                   |
|-----------------|---------------------------------------------------------------------------|
|KF_SERVER_NAME   | set the server name (in the server list)                                  |
|KF_LOGIN         | set the admin password (ingame and in the web ui)                         |
|KF_PASS          | set the admin password                                                    |
|KF_PLAYPASS      | set a passowrd to let players to come on the server, don't set for none   |
|KF_GAMELEN       | game len: 0: sort / 1: medium / 2: long / 3: custom                       |
|KF_DIFFICULTY    | set the game difficulty                                                   |
|KF_MAIL          | admin email address                                                       |

# Build the image:
## Dependencies
You need to have buildkit installed, on arch it's done by
```shell
sudo pacman -S extra/docker-buildx
```

## Build
```shell
export STEAM_LOGIN=...
export STEAM_PASS=

# run the image's build
STEAM_GUARD=xxxxx docker buildx build --secret id=STEAM_LOGIN --secret id=STEAM_PASS --secret id=STEAM_GUARD -t snicolet/kf-server .

# clean the env or just close the terminal
unset STEAM_PASS
unset STEAM_LOGIN
```

# Run the server:
```shell
docker run -d --name kf -p 8075:8075 -p 7707:7707/udp -p 7708:7708/udp -p 7717:7717/udp -p 20560:20560/udp -p 28852:28852 -e KF_LOGIN=login -e KF_PASS=adminpass -e KF_GAMELEN=2 -e KF_SERVER_NAME=KF_Server snicolet/kf-server
```

Or using docker compose:
```yaml
version: "3.1"
services:
  kf:
    image: snicolet/kf-server
    container_name: kf
    ports:
    - 8075:8075
    - 7707:7707/udp
    - 7708:7708/udp
    - 7717:7717/udp
    - 20560:20560/udp
    - 28852:28852
    environment:
    - KF_LOGIN=admin
    - KF_PASS=adminpass
    - KF_GAMELEN=2
    - KF_DIFFICULTY=7
    - KF_SERVER_NAME=Server Name
    restart: unless-stopped
```

then
```shell
docker compose up -d
```
