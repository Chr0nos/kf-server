FROM steamcmd/steamcmd:ubuntu-22
LABEL MAINTAINER=snicolet@student.42.fr

ARG STEAM_LOGIN
ARG STEAM_PASS
ARG STEAM_GUARD

#killing floor server preferences
ENV KF_LOGIN=admin \
	KF_PASS=admin \
	KF_GAMELEN=2 \
	KF_DIFFICULTY=7.0 \
	KF_CONFIG=/kf/server/System/killingfloor-server.ini \
	TERM=xterm \
	USER=root \
	HOME=/root

WORKDIR $HOME

# Update SteamCMD and verify latest version
RUN steamcmd +quit

WORKDIR /kf
COPY setup.sh kf.ini /kf/

#i split this command in case of login failure, to just redo this one
RUN steamcmd +login ${STEAM_LOGIN} ${STEAM_PASS} ${STEAM_GUARD} +force_install_dir /kf/server +app_update 215360 validate +quit

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
