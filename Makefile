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
export INFRA_RESOURCES="$(TF_RESOURCES)/emr"

export TF_MODULES="terraform/modules/providers/aws"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= terraform-emr

IMAGE   = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR     = $(shell pwd)
VERSION ?= 1.3.0

export BASE_IMAGE=alpine
export BASE_VERSION=3.16

export ALPINE_VERSION=3.16
export UBUNTU_VERSION=22.04
export CODEBUILD_VERSION=4.0

# =============== #
#   GET MODULES   #
# =============== #
.PHONY: sub-officials sub-community sub-all codebuild-modules
sub-officials:
	@echo "============================================================"
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "============================================================"
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
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
	@echo "============================================================"
	@echo " Task      : Get CodeBuild Modules "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@./get-modules-codebuild.sh

# ==================== #
#   CLONE REPOSITORY   #
# ==================== #
.PHONY: git-clone
git-clone:
	@echo "============================================================"
	@echo " Task      : Clone Repository Sources "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@./git-clone.sh $(SOURCE) $(TARGET)
	@echo '- DONE -'

# ============================= #
#   BUILD CONTAINER TERRAFORM   #
# ============================= #
.PHONY: build-tf-emr build-tf-emr-alpine build-tf-emr-ubuntu build-tf-emr-codebuild
build-tf-emr:
	@echo "============================================================"
	@echo " Task      : Create Container Image Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-build.sh $(ARGS) alpine Dockerfile.alpine ${ALPINE_VERSION} $(CI_PATH)
	@echo '- DONE -'

build-tf-emr-alpine:
	@echo "============================================================"
	@echo " Task      : Create Container Image Terraform EMR Alpine "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-build.sh $(ARGS) alpine Dockerfile.alpine ${ALPINE_VERSION} $(CI_PATH)
	@echo '- DONE -'

build-tf-emr-ubuntu:
	@echo "============================================================"
	@echo " Task      : Create Container Image Terraform EMR Ubuntu "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-build.sh $(ARGS) ubuntu Dockerfile.ubuntu ${UBUNTU_VERSION} $(CI_PATH)
	@echo '- DONE -'

build-tf-emr-codebuild:
	@echo "============================================================"
	@echo " Task      : Create Container Image Terraform EMR CodeBuild "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-build.sh $(ARGS) codebuild Dockerfile.codebuild ${CODEBUILD_VERSION} $(CI_PATH)
	@echo '- DONE -'

# ============================ #
#   TAGS CONTAINER TERRAFORM   #
# ============================ #
.PHONY: tag-tf-emr tag-tf-emr-alpine tag-tf-emr-ubuntu tag-tf-emr-codebuild
tag-tf-emr:
	@echo "============================================================"
	@echo " Task      : Set Tags Image Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-tag.sh $(ARGS) alpine ${ALPINE_VERSION} $(CI_PATH)
	@echo '- DONE -'

tag-tf-emr-alpine:
	@echo "============================================================"
	@echo " Task      : Set Tags Image Terraform EMR Alpine "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-tag.sh $(ARGS) alpine ${ALPINE_VERSION} $(CI_PATH)
	@echo '- DONE -'

tag-tf-emr-ubuntu:
	@echo "============================================================"
	@echo " Task      : Set Tags Image Terraform EMR Ubuntu "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-tag.sh $(ARGS) ubuntu ${UBUNTU_VERSION} $(CI_PATH)
	@echo '- DONE -'

tag-tf-emr-codebuild:
	@echo "============================================================"
	@echo " Task      : Set Tags Image Terraform EMR CodeBuild "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-tag.sh $(ARGS) codebuild ${CODEBUILD_VERSION} $(CI_PATH)
	@echo '- DONE -'

# ============================ #
#   PUSH CONTAINER TERRAFORM   #
# ============================ #
.PHONY: push-tf-emr push-tf-emr-alpine push-tf-emr-ubuntu push-tf-emr-codebuild
push-tf-emr:
	@echo "============================================================"
	@echo " Task      : Push Container Image Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-push.sh $(ARGS) alpine $(CI_PATH)
	@echo '- DONE -'

push-tf-emr-alpine:
	@echo "============================================================"
	@echo " Task      : Push Container Image Terraform EMR Alpine "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-push.sh $(ARGS) alpine $(CI_PATH)
	@echo '- DONE -'

push-tf-emr-ubuntu:
	@echo "============================================================"
	@echo " Task      : Push Container Image Terraform EMR Ubuntu "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-push.sh $(ARGS) ubuntu $(CI_PATH)
	@echo '- DONE -'

push-tf-emr-codebuild:
	@echo "============================================================"
	@echo " Task      : Push Container Image Terraform EMR CodeBuild "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-push.sh $(ARGS) codebuild $(CI_PATH)
	@echo '- DONE -'

# ============================ #
#   PULL CONTAINER TERRAFORM   #
# ============================ #
.PHONY: pull-tf-emr pull-tf-emr-alpine pull-tf-emr-ubuntu pull-tf-emr-codebuild
pull-tf-emr:
	@echo "============================================================"
	@echo " Task      : Pull Container Image Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-pull.sh $(ARGS) alpine $(CI_PATH)
	@echo '- DONE -'

pull-tf-emr-alpine:
	@echo "============================================================"
	@echo " Task      : Pull Container Image Terraform EMR Alpine "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-pull.sh $(ARGS) alpine $(CI_PATH)
	@echo '- DONE -'

pull-tf-emr-ubuntu:
	@echo "============================================================"
	@echo " Task      : Pull Container Image Terraform EMR Ubuntu "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-pull.sh $(ARGS) ubuntu $(CI_PATH)
	@echo '- DONE -'

pull-tf-emr-codebuild:
	@echo "============================================================"
	@echo " Task      : Pull Container Image Terraform EMR CodeBuild "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@sh ./ecr-pull.sh $(ARGS) codebuild $(CI_PATH)
	@echo '- DONE -'

# =========================== #
#   PROVISIONING INFRA CORE   #
# =========================== #
.PHONY: tf-core-init tf-core-create-workspace tf-core-select-workspace tf-core-plan tf-core-apply
tf-core-init:
	@echo "============================================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform init $(ARGS)
	@echo '- DONE -'
tf-core-create-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-core-select-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-core-plan:
	@echo "============================================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-core-apply:
	@echo "============================================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform apply -auto-approve
	@echo '- DONE -'

# ============================== #
#   PROVISIONING RESOURCES EMR   #
# ============================== #
.PHONY: tf-emr-init tf-emr-create-workspace tf-emr-select-workspace tf-emr-plan tf-emr-apply tf-emr-cmd
tf-emr-init:
	@echo "============================================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(INFRA_RESOURCES) && terraform init $(ARGS)
	@echo '- DONE -'
tf-emr-create-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(INFRA_RESOURCES) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-emr-select-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(INFRA_RESOURCES) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-emr-plan:
	@echo "============================================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(INFRA_RESOURCES) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-emr-apply:
	@echo "============================================================"
	@echo " Task      : Provisioning Terraform EMR "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(INFRA_RESOURCES) && terraform apply -auto-approve $(ARGS)
	@echo '- DONE -'

# =============================== #
#   PROVISIONING SPESIFIC INFRA   #
# =============================== #
.PHONY: tf-emr-cmd
tf-emr-cmd:
	@echo "============================================================"
	@echo " Task      : Terraform Command $(ARGS)"
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(PATH_INFRA) && terraform $(ARGS)
	@echo '- DONE -'
