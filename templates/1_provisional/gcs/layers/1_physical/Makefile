ROOT_DIR:=$(shell git rev-parse --show-toplevel)

include ${ROOT_DIR}/provisionners/terraform._.mk

APP_NAME:=$(shell basename $(ROOT_DIR))
RUN_DIR:=$(shell echo ${ROOT_DIR})
LAYER_NAME:=$(shell basename $(shell pwd))
WORKSPACE_NAME:=$(shell git rev-parse --abbrev-ref HEAD || echo "sample")
TERRAFORM_COMMAND:=TF_DATA_DIR=${RUN_DIR}/.k2/state/${LAYER_NAME}/${WORKSPACE_NAME} ${TOFU_EXECUTABLE}

validate: prepare 
	$(info Validate the environment)	
	${TERRAFORM_COMMAND} validate -var-file=${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${RUN_DIR}"

prepare: terraform_auth
	${TERRAFORM_COMMAND} init -backend-config="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.backend.hcl" -backend-config="prefix=k2/${APP_NAME}/${WORKSPACE_NAME}/${LAYER_NAME}"
	${TOFU_EXECUTABLE} fmt

plan: prepare
	$(info Plan the environment)
	${TERRAFORM_COMMAND} plan  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${RUN_DIR}"

apply: prepare
	$(info Apply the environment)
	${TERRAFORM_COMMAND} apply -auto-approve  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${RUN_DIR}"

destroy: prepare
	$(info Destroy the environment)
	${TERRAFORM_COMMAND} destroy  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${RUN_DIR}"

graph: validate
	$(info Generate the graph)
	${TERRAFORM_COMMAND} graph  


