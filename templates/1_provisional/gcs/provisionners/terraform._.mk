ROOT_DIR:=$(shell git rev-parse --show-toplevel)
TERRAFORM_COMMAND:=TF_DATA_DIR=$(shell pwd)/.k2/state $(shell pwd)/.k2/bin/tofu 

terraform_auth:
	bash ${ROOT_DIR}/provisionners/terraform.auth.sh 

terraform_install:	 	 
	bash ${ROOT_DIR}/provisionners/terraform.install.sh 

terraform_uninstall:
	bash ${ROOT_DIR}/provisionners/terraform.uninstall.sh


