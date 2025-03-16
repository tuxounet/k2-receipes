#!/bin/bash
START_DIR=$(pwd)

if [ ! -d ${START_DIR}/.k2/state ]
then
    echo "Le répertoire de stockage des états Terraform n'existe pas. Création en cours..."
    mkdir -p ${START_DIR}/.k2/state
else
    echo "Le répertoire de stockage des états Terraform existe déjà."
fi