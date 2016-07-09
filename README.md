#build args:
|Variable       | Utility                                         |
|---------------|-------------------------------------------------|
|STEAM_LOGIN    | set the steam login to retrive the server files |
|STEAM_PASS     | set the steam password                          |
|STEAM_GUARD    | steam guard code (don't set if not needed)      |

#environements variables
|Variable         | Utility                                                                   |
|-----------------|---------------------------------------------------------------------------|
|KF_SERVER_NAME   | set the server name (in the server list)                                  |
|KF_LOGIN         | set the admin password (ingame and in the web ui)                         |
|KF_PASS          | set the admin password                                                    |
|KF_PLAYPASS      | set a passowrd to let players to come on the server, don't set for none   |
|KF_GAMELEN       | game len: 0: sort / 1: medium / 2: long / 3: custom                       |
|KF_DIFFICULTY    | set the game difficulty                                                   |
|KF_MAIL          | admin email address                                                       |

#to build the image:
####docker build -t killingfloor --build-arg STEAM_LOGIN=login --build-arg STEAM_PASS=pass .

#to run the server:
####docker run -d --name kf -p 8075:8075 -p 7707:7707/udp -p 7708:7708/udp -p 20560:20560/udp -p 28852:28852 -e KF_LOGIN=login -e KF_PASS=adminpass -e KF_GAMELEN=2 -e KF_SERVER_NAME=KF_Server killingfloor
