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