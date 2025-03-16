#!/bin/bash
START_DIR=$(pwd)

TOFU_VERSION="1.9.0"
TOFU_PLATFORM="linux"
TOFU_ARCH="amd64"

if [ ! -f  ${START_DIR}/.k2/bin/tofu ] ; then
	echo "OpenTofu n'est pas installé. Installation en cours..."
	mkdir -p ${START_DIR}/.k2/tmp/tofu
	curl -o ${START_DIR}/.k2/tmp/tofu/tofu.tar.gz -fsL https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_${TOFU_PLATFORM}_${TOFU_ARCH}.tar.gz 
	cd ${START_DIR}/.k2/tmp/tofu
	tar -xvzf  ./tofu.tar.gz   
	mkdir -p ${START_DIR}/.k2/bin
	mv tofu ${START_DIR}/.k2/bin/tofu
	chmod +x ${START_DIR}/.k2/bin/tofu
	rm -rf ${START_DIR}/.k2/tmp/tofu
else
	echo "OpenTofu est déjà installé."
fi

 
