ROOT_DIR:=$(shell git rev-parse --show-toplevel)

TOFU_EXECUTABLE:=${ROOT_DIR}/.k2/bin/tofu

terraform_auth:
	bash ${ROOT_DIR}/provisionners/terraform.auth.sh 

terraform_install:	 	 
	bash ${ROOT_DIR}/provisionners/terraform.install.sh 

terraform_uninstall:
	bash ${ROOT_DIR}/provisionners/terraform.uninstall.sh


