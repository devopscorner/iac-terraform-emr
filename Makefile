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
export TF_PATH="terraform/environment/providers/aws/infra"
export TF_CORE="${TF_PATH}/core"
export TF_RESOURCES="${TF_PATH}/resources"
export TF_STATE="${TF_PATH}/tfstate"

export TF_MODULES="terraform/modules/providers/aws"

export CI_REGISTRY     ?= YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= terraform-emr

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

BASE_IMAGE     = ubuntu
BASE_VERSION   = 20.04

# =============== #
#   GET MODULES   #
# =============== #
.PHONY: sub-officials sub-community sub-all
sub-officials:
	@echo "============================================"
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@mkdir -p ${TF_MODULES}/officials
	@./get-officials.sh
	@echo '- DONE -'

sub-community:
	@echo "============================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@mkdir -p ${TF_MODULES}/community
	@./get-community.sh
	@echo '- DONE -'

sub-all:
	@make sub-officials
	@echo ""
	@make sub-community
	@echo ""
	@echo "---"
	@echo '- ALL DONE -'

# ============================= #
#   BUILD CONTAINER TERRAFORM   #
# ============================= #
.PHONY: build-tf-emr tag-tf-emr push-tf-emr
build-tf-emr:
	@echo "=================================================="
	@echo " Task      : Create Container Image Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "=================================================="
	@sh ./ecr-build-alpine.sh
	@echo '- DONE -'

# ============================ #
#   TAGS CONTAINER TERRAFORM   #
# ============================ #
tag-tf-emr:
	@echo "=========================================="
	@echo " Task      : Set Tags Image Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "=========================================="
	@sh ./ecr-tag-alpine.sh
	@echo '- DONE -'

# ============================ #
#   PUSH CONTAINER TERRAFORM   #
# ============================ #
push-tf-emr:
	@echo "================================================="
	@echo " Task      : Push Container Image Terraform EMR  "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@sh ./ecr-push-alpine.sh
	@echo '- DONE -'

# =========================== #
#   PROVISIONING INFRA CORE   #
# =========================== #
.PHONY: tf-core tf-emr
tf-core:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform Core "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${TF_CORE} && terraform apply
	@echo '- DONE -'

# ============================== #
#   PROVISIONING RESOURCES EMR   #
# ============================== #
tf-emr:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd ${TF_RESOURCES}/emr && terraform apply
	@echo '- DONE -'
