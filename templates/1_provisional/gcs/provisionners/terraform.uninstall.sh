#!/bin/bash
START_DIR=$(pwd)

if [ -f  ${START_DIR}/.k2/bin/tofu ] ; then
	echo "OpenTofu est installé. Désinstallation en cours..."
    rm -rf ${START_DIR}/.k2/bin/tofu
	
else
	echo "OpenTofu n'est pas installé."
fi

 
