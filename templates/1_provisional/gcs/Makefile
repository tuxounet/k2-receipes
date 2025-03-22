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
	make -C ${RUN_DIR}/layers/2_technical validate
	make -C ${RUN_DIR}/layers/3_logical validate
	make -C ${RUN_DIR}/layers/4_functionnal validate

plan:  setup
	$(info Plan the environment)
	make -C ${RUN_DIR}/layers/1_physical plan
	make -C ${RUN_DIR}/layers/2_technical plan
	make -C ${RUN_DIR}/layers/3_logical plan
	make -C ${RUN_DIR}/layers/4_functionnal plan

apply:  setup
	$(info Apply the environment)
	make -C ${RUN_DIR}/layers/1_physical apply
	make -C ${RUN_DIR}/layers/2_technical apply
	make -C ${RUN_DIR}/layers/3_logical apply
	make -C ${RUN_DIR}/layers/4_functionnal apply

destroy:  setup
	$(info Destroy the environment)
	make -C ${RUN_DIR}/layers/4_functionnal destroy
	make -C ${RUN_DIR}/layers/3_logical destroy
	make -C ${RUN_DIR}/layers/2_technical destroy	
	make -C ${RUN_DIR}/layers/1_physical destroy




