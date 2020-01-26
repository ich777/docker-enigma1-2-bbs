FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl git gcc python2.7 arj p7zip-full lhasa unrar-free lrzsz libimage-exiftool-perl xdms make build-essential libasound2 libasound2-data libasyncns0 libbsd0 libcaca0 libcap2 libdbus-1-3 libflac8 libfontenc1 libfreetype6 libgpm2 libice6 libogg0 libpng16-16 libpulse0 libsdl1.2debian libslang2 libsm6 libsndfile1 libvorbis0a libvorbisenc2 libwrap0 libx11-6 libx11-data libx11-xcb1 libxau6 libxcb1 libxdmcp6 libxext6 libxi6 libxtst6 libxxf86vm1 x11-common xfonts-encodings xfonts-utils && \
	curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
	apt-get -y install --no-install-recommends nodejs && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/enigma-bbs"
ENV FORCE_UPDATE=""
ENV ENIGMABBS_DL_URL="https://github.com/NuSkooler/enigma-bbs.git"
ENV NVM_URI="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh"
ENV ENIGMABBS_F_U=""
ENV NVM_F_U=""
ENV UMASK=000
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID enigma-bbs && \
	chown -R enigma-bbs $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/ && \
	chown -R enigma-bbs /opt/scripts

USER enigma-bbs

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]