TERRAFORM_COMMAND:=TF_DATA_DIR=$(shell pwd)/.k2/state $(shell pwd)/.k2/bin/tofu 

terraform_auth:
	bash ./provisionners/terraform.auth.sh 

terraform_install:	 	 
	bash ./provisionners/terraform.install.sh 

terraform_uninstall:
	bash ./provisionners/terraform.uninstall.sh


