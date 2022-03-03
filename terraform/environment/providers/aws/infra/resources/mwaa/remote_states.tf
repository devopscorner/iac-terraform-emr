# ==========================================================================
#  Resources: MWAA / remove_states.tf (Remote Terraform References)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - DynamoDB
#    - S3 Bucket
#    - Region
# ==========================================================================
data "terraform_remote_state" "core_state" {
  backend   = "s3"
  workspace = local.env

  config = {
    bucket = "devopscorner-terraform-remote-state"
    key    = "core/terraform.tfstate"
    region = var.aws_region
  }
}