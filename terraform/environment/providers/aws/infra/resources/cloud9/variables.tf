# ==========================================================================
#  Resources: Cloud9 / variables.tf (Environment)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Input Variable for AWS Provider
# ==========================================================================

# ------------------------------------
#  AWS Region
# ------------------------------------
variable "aws_region" {
  type        = string
  description = "AWS Region Target Deployment"
  default     = "ap-southeast-1"
}

# ------------------------------------
#  Workspace
# ------------------------------------
variable "env" {
  type        = map(string)
  description = "Workspace Environment Selection"
  default = {
    lab     = "lab"
    staging = "staging"
    prod    = "prod"
  }
}

# ------------------------------------
#  Environment Resources Tags
# ------------------------------------
variable "environment" {
  type        = map(string)
  description = "Target Environment (tags)"
  default = {
    lab     = "RND"
    staging = "STG"
    prod    = "PROD"
  }
}

# ------------------------------------
#  Department Tags
# ------------------------------------
variable "department" {
  type        = string
  description = "Department Owner"
  default     = "DEVOPS"
}

# ------------------------------------
#  KMS Key
# ------------------------------------
variable "kms_key" {
  type        = map(string)
  description = "KMS Key References"
  default = {
    lab     = "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH"
    staging = "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH"
    prod    = "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH"
  }
}

# ------------------------------------
#  KMS Environment
# ------------------------------------
variable "kms_env" {
  type        = map(string)
  description = "KMS Key Environment"
  default = {
    lab     = "RnD"
    staging = "Staging"
    prod    = "Production"
  }
}

# ------------------------------------
#  Bucket Name
# ------------------------------------
variable "cloud9_bucket_name" {
  type        = string
  description = "Cloud9 Bucket Name"
  default     = "devopscorner-cloud9"
}

# ------------------------------------
#  Cloud9
# ------------------------------------
variable "cloud9_env" {
  type        = string
  description = "Cloud9 Environment Name"
  default     = "devopscorner-ide"
}

# We choose EFS One Zone Storage for cheaper option
variable "cloud9_efs_az" {
  description = "Cloud9 EFS availability zone"
  type        = map(string)
  default = {
    lab     = "ap-southeast-1a"
    staging = "ap-southeast-1b"
    prod    = "ap-southeast-1b"
  }
}

# Max EC2 spot price
variable "cloud9_spot_price" {
  # https://aws.amazon.com/ec2/spot/pricing/
  # https://docs.aws.amazon.com/powershell/latest/reference/items/Get-EC2SpotPriceHistory.html
  type = string
  # t3.micro  = 0.004
  # t3.small  = 0.0079
  # t3.medium = 0.0158
  # t3.large  = 0.0317
  default = "0.0079"
}

# Type of the EC2 instance you want to launch
variable "cloud9_instance_type" {
  type    = string
  default = "t3.small"
}

# EC2 will fetch and run script on this url after boot
variable "cloud9_user_data_url" {
  type    = string
  default = "https://raw.githubusercontent.com/devopscorner/iac-terraform-emr/main/terraform/environment/providers/aws/infra/resources/cloud9/userdata/user-data.sh"
}

# Used in Security Group for accessing EC2
# You can set the value as environment variable `export TF_VAR_cloud9_my_ip=YOUR_IP/32`
variable "cloud9_my_ip" {
  type        = string
  description = "Your IP Address"
  default     = "118.136.0.0/16"
}

# This ips should be list of AWS Cloud9 IPs according to your selected region
# See https://docs.aws.amazon.com/cloud9/latest/user-guide/ip-ranges.html
# This default uses ap-southeast-1 Cloud9 IP address range
variable "cloud9_ips" {
  type        = list(any)
  description = "Cloud9 IPs Range"
  default     = ["13.250.186.128/27", "13.250.186.160/27"]
}

# Your SSH public key
variable "cloud9_ssh_public_key" {
  type        = string
  description = "SSH Public Key"
  ## file:///Users/[username]/.ssh/id_rsa.pub
  default     = ""
}

# ------------------------------------
#  Bucket Terraform State
# ------------------------------------
variable "tfstate_encrypt" {
  type        = bool
  description = "Name of bucket to store tfstate"
  default     = true
}

variable "tfstate_bucket" {
  type        = string
  description = "Name of bucket to store tfstate"
  default     = "devopscorner-terraform-remote-state"
}

variable "tfstate_dynamodb_table" {
  type        = string
  description = "Name of dynamodb table to store tfstate"
  default     = "devopscorner-terraform-state-lock"
}

variable "tfstate_path" {
  type        = string
  description = "Path .tfstate in Bucket"
  default     = "resources/cloud9/terraform.tfstate"
}
