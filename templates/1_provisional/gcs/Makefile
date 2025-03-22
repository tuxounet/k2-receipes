include provisionners/terraform._.mk

RUN_DIR:=$(shell pwd)
WORKSPACE_NAME:=$(shell git rev-parse --abbrev-ref HEAD || echo "sample")

setup: terraform_install
	$(info Setup the environment)
	

nuke: terraform_uninstall
	$(info Nuke the environment)

validate: setup 
	$(info Validate the environment)	
	make -C ${RUN_DIR}/layers/1_physical validate

plan:  setup
	$(info Plan the environment)
	make -C ${RUN_DIR}/layers/1_physical plan

apply:  setup
	$(info Apply the environment)
	make -C ${RUN_DIR}/layers/1_physical apply

destroy:  setup
	$(info Destroy the environment)
	make -C ${RUN_DIR}/layers/1_physical destroy



