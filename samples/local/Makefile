WORKSPACE_NAME:=$(shell git rev-parse --abbrev-ref HEAD || echo "sample")

setup: 
	$(info Setup the environment)
	k2 apply --inventory ../../k2.inventory.yaml
	make -C 1_provisional setup
	
nuke:  
	$(info Nuke the environment)
	k2 destroy --inventory ../../k2.inventory.yaml

validate:
	$(info Validate the environment)	
	make -C 1_provisional validate	

prepare: 
	$(info Prepare the environment)
	make -C 1_provisional prepare
	
plan: 
	$(info Plan the environment)
	make -C 1_provisional plan

apply:
	$(info Apply the environment)
	make -C 1_provisional apply

destroy:
	$(info Destroy the environment)
	make -C 1_provisional destroy
