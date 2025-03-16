include provisionners/terraform._.mk

WORKSPACE_NAME:=sandbox

setup: terraform_install
	$(info Setup the environment)
	

nuke: terraform_uninstall
	$(info Nuke the environment)

validate: setup 
	$(info Validate the environment)	
	${TERRAFORM_COMMAND} validate -var-file="./spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}"

prepare: setup terraform_auth
	${TERRAFORM_COMMAND} fmt
	${TERRAFORM_COMMAND} init -backend-config=./spaces/${WORKSPACE_NAME}.backend.hcl

plan: prepare
	$(info Plan the environment)
	${TERRAFORM_COMMAND} plan  -var-file="./spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}"

apply: prepare
	$(info Apply the environment)
	${TERRAFORM_COMMAND} apply -auto-approve  -var-file="./spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}"

destroy: prepare
	$(info Destroy the environment)
	${TERRAFORM_COMMAND} destroy  -var-file="./spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}"

graph: validate
	$(info Generate the graph)
	${TERRAFORM_COMMAND} graph  