include ../../provisionners/terraform._.mk

ROOT_DIR:=$(shell git rev-parse --show-toplevel)

WORKSPACE_NAME:=$(shell git rev-parse --abbrev-ref HEAD || echo "sample")

setup: terraform_install
	$(info Setup the environment)
	

nuke: terraform_uninstall
	$(info Nuke the environment)

validate: setup 
	$(info Validate the environment)	
	${TERRAFORM_COMMAND} validate -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${ROOT_DIR}"

prepare: setup terraform_auth
	${TERRAFORM_COMMAND} init -backend-config="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.backend.hcl"
	${TERRAFORM_COMMAND} fmt

plan: prepare
	$(info Plan the environment)
	${TERRAFORM_COMMAND} plan  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${ROOT_DIR}"

apply: prepare
	$(info Apply the environment)
	${TERRAFORM_COMMAND} apply -auto-approve  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${ROOT_DIR}"

destroy: prepare
	$(info Destroy the environment)
	${TERRAFORM_COMMAND} destroy  -var-file="${ROOT_DIR}/spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${ROOT_DIR}"

graph: validate
	$(info Generate the graph)
	${TERRAFORM_COMMAND} graph  


