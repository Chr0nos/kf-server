#!/bin/sh
if (test -d /kf/server/System)
then
	cd /kf/server/System
	cp -v Default.ini ${KF_CONFIG}
	sed -i s/AdminPassword=/AdminPassword=${KF_PASS}/g ${KF_CONFIG}
	sed -i s/GamePassword=/GamePassword=${KF_PLAYPASS}/g ${KF_CONFIG}
	sed -i s/AdminName=/AdminName=$KF_LOGIN/g ${KF_CONFIG}
	sed -i s/CharSet="iso-8859-1"/CharSet="utf-8"/g UWeb.int
	sed -i s/ServerName=/ServerName=${KF_SERVER_NAME}/g ${KF_CONFIG}
	sed -i s/AdminEmail=/AdminEmail=${KF_MAIL}/g ${KF_CONFIG}
	sed -i s/KFGameLength=2/KFGameLength=${KF_GAMELEN}/g ${KF_CONFIG}
	sed -i s/GameDifficulty=7.000000/GameDifficulty=${KF_DIFFICULTY}/g ${KF_CONFIG}
	./ucc-bin server KF-BioticsLab.rom?game=KFmod.KFGameType -nohomedir ini=${KF_CONFIG}
else
	echo "Do not run this script outside the docker image"
fi

