FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl git gcc python2.7 arj p7zip-full lhasa unrar-free lrzsz libimage-exiftool-perl xdms make build-essential && \
	curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
	apt-get -y install --no-install-recommends nodejs && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/enigma-bbs"
ENV ENIGMABBS_DL_URL="https://github.com/NuSkooler/enigma-bbs.git"
ENV NVM_URI="https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh"
ENV ENIGMABBS_F_U=""
ENV NVM_V=10
ENV NVM_F_U=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="enigma-bbs"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]