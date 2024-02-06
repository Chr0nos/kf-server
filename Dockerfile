FROM steamcmd/steamcmd:ubuntu-22
LABEL MAINTAINER=snicolet@student.42.fr

WORKDIR $HOME

# Update SteamCMD and verify latest version
RUN steamcmd +quit

# Fetch the game files, can't do it anomymously
RUN --mount=type=secret,id=STEAM_LOGIN \
	--mount=type=secret,id=STEAM_PASS \
	--mount=type=secret,id=STEAM_GUARD \
	steamcmd +login $(cat /run/secrets/STEAM_LOGIN) $(cat /run/secrets/STEAM_PASS) $(cat /run/secrets/STEAM_GUARD) +force_install_dir /kf/server +app_update 215360 validate +quit

#killing floor server preferences
ENV KF_LOGIN=admin \
	KF_PASS=admin \
	KF_GAMELEN=2 \
	KF_DIFFICULTY=7.0 \
	KF_CONFIG=/kf/server/System/killingfloor-server.ini \
	TERM=xterm

RUN cp -v /kf/server/System/Default.ini /kf/server/System/Default.ini.bak
COPY setup.sh kf.ini /kf/
WORKDIR /kf/server/System
RUN chmod +x /kf/setup.sh
COPY kf.ini /kf/server/System/Default.ini
COPY mods/*.u mods/*.ucl mods/*.int mods/*.ini /kf/server/System/
COPY mods/*.utx /kf/server/Textures/

EXPOSE 7707/udp \
	7708/udp \
	7717/udp \
	28852 \
	28852/udp \
	8075 \
	20560/udp

ENTRYPOINT ["/kf/setup.sh"]
