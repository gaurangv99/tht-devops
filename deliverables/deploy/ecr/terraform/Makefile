THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
THIS_DIR      := $(dir $(realpath $(THIS_MAKEFILE)))

.PHONY: tf-ecr-init
tf-ecr-init:
	@@cd $(THIS_DIR) && terraform init 

.PHONY: tf-ecr-destroy
tf-ecr-destroy:
	@@cd $(THIS_DIR) && terraform destroy

.PHONY: tf-ecr-apply
tf-ecr-apply: tf-ecr-plan
	@@cd $(THIS_DIR) && terraform apply tfplan.json

.PHONY: tf-ecr-plan
tf-ecr-plan:
	@@cd $(THIS_DIR) && terraform plan -out tfplan.json

.PHONY: tf-ecr-graph
tf-ecr-graph:
	@@cd $(THIS_DIR) && terraform graph -type=plan
