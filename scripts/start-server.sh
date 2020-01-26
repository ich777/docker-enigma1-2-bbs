#!/bin/bash
echo "---Setting umask to ${UMASK}---"
umask ${UMASK}

echo "---Sleep zZz---"
sleep infinity

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