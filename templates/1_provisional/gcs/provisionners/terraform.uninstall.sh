#!/bin/bash
START_DIR=$(pwd)
ROOT_DIR=$(git rev-parse --show-toplevel)
RUN_DIR=${ROOT_DIR}/.k2

if [ -f  ${RUN_DIR}/bin/tofu ] ; then
	echo "OpenTofu est installé. Désinstallation en cours..."
    rm -rf ${RUN_DIR}/bin/tofu
	
else
	echo "OpenTofu n'est pas installé."
fi

 
