#!/bin/bash
set -x
START_DIR=$(pwd)

gcloud auth application-default print-access-token > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Les credentials Google Cloud ne sont pas installés. Installation en cours..."
    gcloud auth application-default login
else
    echo "Les credentials Google Cloud sont déjà installés."
fi

ROOT_DIR=$(git rev-parse --show-toplevel)
RUN_DIR=${ROOT_DIR}/.k2

WORKSPACE_NAME:=$(git rev-parse --abbrev-ref HEAD || echo "sample")
mkdir -p ${RUN_DIR}/state/${WORKSPACE_NAME}

