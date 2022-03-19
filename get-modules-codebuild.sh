#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Get All Terraform Submodules
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

TITLE="TERRAFORM MODULES" # script name
VER="2.3"                 # script version

cd ${CODEBUILD_SRC_DIR}/terraform
rm -rf modules

mkdir -p modules/providers/aws/community
mkdir -p modules/providers/aws/officials

### ================================= ###

## Inside `terraform` folder
SUBMODULE_COMMUNITY="${CODEBUILD_SRC_DIR}/module_community.lst"
SUBMODULE_OFFICIALS="${CODEBUILD_SRC_DIR}/module_officials.lst"

cd modules/providers/aws/community

while IFS= read line; do
  # skip_exists $line
  git clone --depth 1 $line
  echo ''
done <"$SUBMODULE_COMMUNITY"
echo '- COMMUNITY MODULES DOWNLOADED -'

### ================================= ###

cd ../officials

while IFS= read line; do
  # skip_exists $line
  git clone --depth 1 $line
  echo ''
done <"$SUBMODULE_OFFICIALS"
echo '- OFFICIALS MODULE DOWNLOADED -'

