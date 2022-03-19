# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_APP=`pwd`
export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="."
export PATH_DOCKER="."
export PROJECT_NAME="iac-terraform-emr"
export TF_PATH="terraform/environment/providers/aws/infra"
export TF_CORE="$(TF_PATH)/core"
export TF_RESOURCES="$(TF_PATH)/resources"
export TF_STATE="$(TF_PATH)/tfstate"

export TF_MODULES="terraform/modules/providers/aws"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= iac-terraform-emr

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
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "============================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@mkdir -p $(TF_MODULES)/community
	@cd $(PATH_APP) && ./get-community.sh

sub-all:
	@make sub-officials
	@echo ''
	@make sub-community
	@echo ''
	@echo '---'
	@echo '- ALL DONE -'

codebuild-modules:
	@echo "============================================"
	@echo " Task      : Get CodeBuild Modules "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@./get-modules-codebuild.sh

# ============================= #
#   BUILD CONTAINER TERRAFORM   #
# ============================= #
.PHONY: build-tf-emr tag-tf-emr push-tf-emr
build-tf-emr:
	@echo "=================================================="
	@echo " Task      : Create Container Image Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "=================================================="
	@sh ./ecr-build-alpine.sh $(ARGS)
	@echo '- DONE -'

# ============================ #
#   TAGS CONTAINER TERRAFORM   #
# ============================ #
tag-tf-emr:
	@echo "=========================================="
	@echo " Task      : Set Tags Image Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "=========================================="
	@sh ./ecr-tag-alpine.sh $(ARGS)
	@echo '- DONE -'

# ============================ #
#   PUSH CONTAINER TERRAFORM   #
# ============================ #
push-tf-emr:
	@echo "================================================="
	@echo " Task      : Push Container Image Terraform EMR  "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@sh ./ecr-push-alpine.sh $(ARGS)
	@echo '- DONE -'

# ============================ #
#   PULL CONTAINER TERRAFORM   #
# ============================ #
pull-tf-emr:
	@echo "================================================="
	@echo " Task      : Pull Container Image Terraform EMR  "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@sh ./ecr-pull-alpine.sh $(ARGS)
	@echo '- DONE -'

# =========================== #
#   PROVISIONING INFRA CORE   #
# =========================== #
.PHONY: tf-core-init tf-core-create-workspace tf-core-select-workspace tf-core-plan tf-core-apply
tf-core-init:
	@echo "============================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_CORE) && terraform init $(ARGS)
	@echo '- DONE -'
tf-core-create-workspace:
	@echo "============================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_CORE) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-core-select-workspace:
	@echo "============================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_CORE) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-core-plan:
	@echo "============================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_CORE) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-core-apply:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_CORE) && terraform apply -auto-approve
	@echo '- DONE -'

# ============================== #
#   PROVISIONING RESOURCES EMR   #
# ============================== #
.PHONY: tf-emr-init tf-emr-create-workspace tf-emr-select-workspace tf-emr-plan tf-emr-apply tf-emr-cmd
tf-emr-init:
	@echo "============================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_RESOURCES)/emr && terraform init $(ARGS)
	@echo '- DONE -'
tf-emr-create-workspace:
	@echo "============================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_RESOURCES)/emr && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-emr-select-workspace:
	@echo "============================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_RESOURCES)/emr && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-emr-plan:
	@echo "============================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_RESOURCES)/emr && terraform plan $(ARGS)
	@echo '- DONE -'
tf-emr-apply:
	@echo "============================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(TF_RESOURCES)/emr && terraform apply -auto-approve $(ARGS)
	@echo '- DONE -'

# =============================== #
#   PROVISIONING SPESIFIC INFRA   #
# =============================== #
.PHONY: tf-emr-cmd
tf-emr-cmd:
	@echo "============================================"
	@echo " Task      : Terraform Command $(ARGS)"
	@echo " Date/Time : `date`"
	@echo "============================================"
	@cd $(PATH_INFRA) && terraform $(ARGS)
	@echo '- DONE -'
