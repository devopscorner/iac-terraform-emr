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
#  AWS Zone
# ------------------------------------
variable "aws_az" {
  type        = map(string)
  description = "AWS Zone Target Deployment"
  default = {
    lab     = "ap-southeast-1a"
    staging = "ap-southeast-1b"
    prod    = "ap-southeast-1b"
  }
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
#  DNS (Public)
# ------------------------------------
variable "dns_zone" {
  type = map(string)
  default = {
    lab     = "ZONE_ID_PUBLIC"
    staging = "ZONE_ID_PUBLIC"
    prod    = "ZONE_ID_PUBLIC"
  }
}

variable "dns_url" {
  type = map(string)
  default = {
    lab     = "awscb.id"
    staging = "awscb.id"
    prod    = "awscb.id"
  }
}

# ------------------------------------
#  Jumphost
# ------------------------------------
variable "jumphost_name" {
  type        = string
  description = "Jumphost Name"
  default     = "jumphost"
}

variable "bucket_name" {
  type        = string
  description = "Bucket Name"
  default     = "jumphost-emr"
}

variable "ec2_type" {
  type        = map(string)
  description = "Jumphost EC2 Instance Type"
  default = {
    lab     = "t3.small"
    staging = "t3.medium"
    prod    = "t3.large"
  }
}

variable "jumphost_my_ip" {
  type        = string
  description = "Your IP Address"
  default     = "118.136.0.0/16"
}

# ------------------------------------
#  SSH public key
# ------------------------------------
#
variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
  ## file:///Users/[username]/.ssh/id_rsa.pub
  default     = ""
}

# ------------------------------------
#  AMI Linux
# ------------------------------------
variable "ami" {
   type        = string
   description = "AWS Linux AMI to use.  Must match availability zone, instance type, etc"
   ### AWS Linux ###
   # default     = "ami-0dc5785603ad4ff54"
   ### Ubuntu ###
   default   = "ami-0fed77069cd5a6d6c"
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
  default     = "resources/jumphost/terraform.tfstate"
}
