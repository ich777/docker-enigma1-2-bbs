FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends curl git gcc python2.7 arj p7zip-full lhasa unrar-free lrzsz libimage-exiftool-perl xdms && \
	curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
	apt-get -y install --no-install-recommends nodejs && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/enigma-bbs"
ENV FORCE_UPDATE=""
ENV ENIGMABBS_DL_URL="https://github.com/NuSkooler/enigma-bbs/archive/master.zip"
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