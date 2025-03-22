#!/bin/bash
set -x
ROOT_DIR=$(git rev-parse --show-toplevel)
RUN_DIR=${ROOT_DIR}/.k2

TOFU_VERSION="1.9.0"
TOFU_PLATFORM="linux"
TOFU_ARCH="amd64"

if [ ! -f  ${RUN_DIR}/bin/tofu ] ; then
	echo "OpenTofu n'est pas installé. Installation en cours..."
	mkdir -p ${RUN_DIR}/tmp/tofu
	curl -o ${RUN_DIR}/tmp/tofu/tofu.tar.gz -fsL https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_${TOFU_PLATFORM}_${TOFU_ARCH}.tar.gz 
	cd ${RUN_DIR}/tmp/tofu
	tar -xvzf  ./tofu.tar.gz   
	mkdir -p ${RUN_DIR}/bin
	mv tofu ${RUN_DIR}/bin/tofu
	chmod +x ${RUN_DIR}/bin/tofu
	rm -rf ${RUN_DIR}/tmp/tofu
else
	echo "OpenTofu est déjà installé."
fi

 
