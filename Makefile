# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="."
export PATH_DOCKER="."
export PROJECT_NAME="iac-terraform-emr"
export TF_PATH="terraform/environment/providers/aws"

export CI_REGISTRY     ?= YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= terraform-emr

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

BASE_IMAGE     = ubuntu
BASE_VERSION   = 20.04

.PHONY: sub-official sub-community sub-all
sub-official:
	@echo "============================================"
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@mkdir -p modules
	@./get-official.sh
	@echo '- DONE -'

sub-community:
	@echo "============================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@mkdir -p modules
	@./get-community.sh
	@echo '- DONE -'

sub-all:
	@make sub-official
	@echo ""
	@make sub-community
	@echo ""
	@echo "---"
	@echo '- ALL DONE -'

.PHONY: build-tf-emr push-tf-emr push-container-tf-emr
build-tf-emr:
	@echo "================================================="
	@echo " Task      : Create Container Image CI/CD EMR "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/tf-emr && ./docker-build.sh
	@echo '- DONE -'

push-tf-emr:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD EMR "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/tf-emr && ./docker-push.sh
	@echo '- DONE -'

push-container-tf-emr:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD EMR "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/tf-emr && ./docker-build.sh
	@cd ${PATH_DOCKER}/tf-emr && ./docker-push.sh
	@echo '- DONE -'

.PHONY: tf-core tf-emr
tf-core:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform Core "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${TF_PATH}/infra/core && terraform apply
	@echo '- DONE -'

tf-emr:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${TF_PATH}/infra/resources/emr && terraform apply
	@echo '- DONE -'
