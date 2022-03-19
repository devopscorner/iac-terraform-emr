#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Get Official Terraform Submodules
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer DevOpsCornerId (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

TITLE="TERRAFORM COMMUNITY SUBMODULES" # script name
VER="2.3"                              # script version

PATH_APP=$(pwd)
SUBMODULE_TERRAFORM="${PATH_APP}/module_officials.lst"
PATH_MODULES="./terraform/modules/providers/aws/officials"

cd $PATH_MODULES
while IFS= read line; do
  # skip_exists $line
  git clone --depth 1 $line
  echo ''
done <"$SUBMODULE_TERRAFORM"
echo "- DOWNLOAD DONE -"