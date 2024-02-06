#!/bin/sh
if (test -d /kf/server/System)
then
	cd /kf/server/System
	sed -i s/AdminPassword=/AdminPassword=${KF_PASS}/g Default.ini
	sed -i s/GamePassword=/GamePassword=${KF_PLAYPASS}/g Default.ini
	sed -i s/AdminName=/AdminName=$KF_LOGIN/g Default.ini
	sed -i s/ServerName=/ServerName=${KF_SERVER_NAME}/g Default.ini
	sed -i s/AdminEmail=/AdminEmail=${KF_MAIL}/g Default.ini
	export LD_LIBRARY_PATH=/root/.local/share/Steam/steamcmd/linux32:.
	./ucc-bin-real server KF-BioticsLab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=${KF_SLOTS}?Mutator=${KF_MUTATORS}?GameDifficulty=${KF_DIFFICULTY}?KFGameLength=${KF_GAMELEN}?MapVote=true?ScoreBoardDelay=5 -nohomedir
else
	echo "Do not run this script outside the docker image"
fi
