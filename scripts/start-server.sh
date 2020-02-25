#!/bin/bash
echo "---Checking if NVM is installed---"
if [ ! -f ${DATA_DIR}/.nvm/nvm.sh ]; then
	echo "---NVM not found, installing---"
    if curl -o- ${NVM_URI} | bash ; then
    	echo "---NVM installed successfully---"
	else
    	echo "---Can't install NVM, putting server into sleep mode---"
        sleep infinity
	fi
else
	echo "---NVM found---"
fi

if [ "${NVM_F_U}" == "true" ]; then
	echo "---Force Update of NVM---"
    if curl -o- ${NVM_URI} | bash ; then
    	echo "---NVM updated successfully---"
	else
    	echo "---Can't update NVM, putting server into sleep mode---"
        sleep infinity
	fi
fi

echo "---Setting up NVM---"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install ${NVM_V}
nvm use ${NVM_V}
nvm alias default ${NVM_V}

echo "---Checking if ENiGMA½ BBS is installed---"
if [ ! -f ${DATA_DIR}/enigma-bbs/main.js ]; then
	echo "---ENiGMA½ BBS not installed, installing...---"
	cd ${DATA_DIR}
	if git clone ${ENIGMABBS_DL_URL} ; then
		echo "---Successfully downloaded ENiGMA½---"
	else
		echo "---Can't download ENiGMA½, putting server into sleep mode---"
	    sleep infinity
	fi
	cd ${DATA_DIR}/enigma-bbs
	npm install
else
	echo "---ENiGMA½ BBS found!---"
fi

if [ "${ENIGMABBS_F_U}" == "true" ]; then
	echo "---Force Update of ENiGMA½ BBS---"
    cd ${DATA_DIR}/enigma-bbs
    if git pull ; then
    	echo "---Git Pull successfull---"
	else
    	echon "---Git Pull unsuccesfull, putting server into sleep mode---"
        sleep infinity
	fi
    npm update
fi

echo "---Preparing Server---"
echo "---Checking for configuration files---"
if [ ! -f ${DATA_DIR}/enigma-bbs/config/config.hjson ]; then
   	echo "---Configuration files not found downloading---"
	cd ${DATA_DIR}/enigma-bbs/config
	if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/docker-enigma1-2-bbs/raw/master/config/config.tar ; then
		echo "---Successfully downloaded configuration files---"
	else
       	echo "---Can't download configuration files, putting server into sleep mode---"
		sleep infinity
	fi
    tar -xvf config.tar
    rm config.tar
else
   	echo "---Configruation files found!---"
fi
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${DATA_DIR}/enigma-bbs
${DATA_DIR}/enigma-bbs/main.js