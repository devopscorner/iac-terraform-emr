#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Get Community Terraform Submodules
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

TITLE="TERRAFORM COMMUNITY SUBMODULES" # script name
VER="2.3"                              # script version

PATH_APP=$(pwd)
SUBMODULE_TERRAFORM="${PATH_APP}/module_community.lst"
PATH_MODULES="./terraform/modules/providers/aws/community"

cd $PATH_MODULES
while IFS= read line; do
  # skip_exists $line
  git clone --depth 1 $line
  echo ''
done <"$SUBMODULE_TERRAFORM"
echo '- DOWNLOAD DONE -'