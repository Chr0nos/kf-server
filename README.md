# Build args:
|Variable       | Utility                                         |
|---------------|-------------------------------------------------|
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
|KF_SLOTS         | how many players can join (should be 6)                                   |
|KF_MUTATORS      | what mutators to enable by default, separate them with a comma (optional) |

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

## Useful readings
- https://steamcommunity.com/app/1250/discussions/0/3317353727670499474/
- https://wiki.tripwireinteractive.com/index.php/Dedicated_Server_(KillingFloor)
- https://wiki.tripwireinteractive.com/index.php/List_of_mutators_(Killing_Floor)
- https://forums.tripwireinteractive.com/index.php?threads/kf-mutator-whitelist-and-fix-submission-thread.94259/

## Others usefull informations
- The whitelist system for maps has been removed by tripwire, all maps except test maps are ok to gain experience on perks

| Mod                     |            version | Status        | Url                                                                                                  |
|-------------------------|--------------------|---------------|------------------------------------------------------------------------------------------------------|
| Patriarch HP Left	      |                1.0 | whitelisted   | https://forums.tripwireinteractive.com/index.php?threads/mutator-patriarch-hp-left.46296/            |
| KFNoDramaMut            |         2009/06/04 | whitelisted   | https://forums.tripwireinteractive.com/index.php?threads/kfnodramamut-disable-random-zed-time.33972/ |
| MutKFAntiBlocker        |                1.1 | whitelisted   |                                                                                                      |
| MutKillMessage       	  |                2.0 | whitelisted   | https://forums.tripwireinteractive.com/index.php?threads/mutator-specimen-kill-messages.52412/       |
| Visible Spectators - W  |                  ? | greylisted    | https://forums.tripwireinteractive.com/index.php?threads/mutator-visible-spectators.83133/           |
| SuperZombieMut          |              2.2.1 | whitelisted   | |
| SuperZombieMut          |              2.3   | greylisted    | |
| ScrN Balance            |              9.51  | blacklisted   | https://forums.tripwireinteractive.com/index.php?threads/mutator-total-game-balance-gunslinger-perk-scrn-balance.82615/ |

note:
- whitelisted == you can use and level your perks
- greylisted == you can use your perks but not level them
- blacklisted == you can't use nor level your perks

# Run the server:
```shell
docker run -d --name kf -p 8075:8075 -p 7707:7707/udp -p 7708:7708/udp -p 7717:7717/udp -p 20560:20560/udp -p 28852:28852 -e KF_LOGIN=login -e KF_PASS=adminpass -e KF_GAMELEN=2 -e KF_SERVER_NAME=KF_Server -e KF_SLOTS=6 -e KF_MUTATORS=MutKFAntiBlocker.MutKFAntiBlocker,KFNoDramaMut.KFNoDramaMut,KFPatHPLeft.MutPatHPLeft,MutKillMessage.MutKillMessage snicolet/kf-server
```

Or using docker compose:
```yaml
version: "3.8"
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
    - 28852:28852/udp
    environment:
    - KF_LOGIN=admin
    - KF_PASS=adminpass
    - KF_GAMELEN=2
    - KF_DIFFICULTY=7
    - KF_SERVER_NAME=The server name
    - KF_SLOTS=6
    - KF_MUTATORS=MutKFAntiBlocker.MutKFAntiBlocker,KFNoDramaMut.KFNoDramaMut,KFPatHPLeft.MutPatHPLeft,MutKillMessage.MutKillMessage
    restart: unless-stopped
    # This part is not mandatory but allow you to mount mods folder,
    # they will be installed at runtime, of course here i suppose you've put
    # your mods into a `my_mods` folder (without keeping the folder structure)
    volumes:
    - ./my_mods:/mods:ro

```

then
```shell
docker compose up -d
```
