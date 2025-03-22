include provisionners/terraform._.mk

RUN_DIR:=$(shell pwd)
WORKSPACE_NAME:=$(shell git rev-parse --abbrev-ref HEAD || echo "sample")

setup: terraform_install
	$(info Setup the environment)
	

nuke: terraform_uninstall
	$(info Nuke the environment)

validate: setup 
	$(info Validate the environment)	
	${TERRAFORM_COMMAND} validate -var-file="./spaces/${WORKSPACE_NAME}.tfvars" -var "space=${WORKSPACE_NAME}" -var "run_dir=${RUN_DIR}"


plan: validate
	$(info Plan the environment)
	make -C ${RUN_DIR}/layers/1_physical plan

apply: validate
	$(info Apply the environment)
	make -C ${RUN_DIR}/layers/1_physical apply

destroy: validate
	$(info Destroy the environment)
	make -C ${RUN_DIR}/layers/1_physical destroy



