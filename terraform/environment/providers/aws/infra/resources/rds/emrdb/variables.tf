# ==========================================================================
#  Resources: RDS / variables.tf (Environment)
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
#  RDS
# ------------------------------------
variable "db_instance_class" {
  type = map(string)
  default = {
    lab     = "db.t3.medium"
    staging = "db.t3.medium"
    prod    = "db.t3.large"
  }
}

variable "retention_db" {
  type = map(number)
  default = {
    lab     = 3
    staging = 3
    prod    = 7
  }
}

variable "vpc_list" {
  type = list(string)
  ## VPC Lab, Staging, Prod
  default = ["vpc-1234567890123456"]
}

# ------------------------------------
#  DNS (Private)
# ------------------------------------
variable "dns_zone" {
  type = map(string)
  default = {
    lab     = "ZONE_ID_PRIVATE"
    staging = "ZONE_ID_PRIVATE"
    prod    = "ZONE_ID_PRIVATE"
  }
}

variable "dns_url" {
  type = map(string)
  default = {
    lab     = "devopscorner.online"
    staging = "devopscorner.online"
    prod    = "devopscorner.online"
  }
}

variable "rds_name" {
  type        = string
  description = "RDS Name"
  default     = "EMRDB-PSQL"
}

variable "rds_storage_size" {
  type = map(number)
  default = {
    lab     = 50
    staging = 100
    prod    = 100
  }
}

variable "rds_engine" {
  type        = string
  description = "RDS Engine DBMS"
  default     = "postgres"
}

variable "rds_version" {
  type        = string
  description = "RDS Version DBMS"
  default     = "14.1"
}

variable "rds_family" {
  type        = string
  description = "RDS Family Version DBMS"
  default     = "postgres14"
}

variable "rds_major_engine_version" {
  type        = string
  description = "RDS Initial Version DBMS"
  default     = "14"
}

variable "vpc_tags" {
  type = map(any)
  default = {
    lab = {
      Environment     = "LAB"
      Name            = "devopscorner-terraform-lab-vpc"
      Department      = "DEVOPS"
      DepartmentGroup = "LAB-DEVOPS"
      ResourceGroup   = "LAB-VPC"
    }
    staging = {
      Environment     = "STAGING"
      Name            = "devopscorner-terraform-staging-vpc"
      Department      = "DEVOPS"
      DepartmentGroup = "STG-DEVOPS"
      ResourceGroup   = "STG-VPC"
    }
    prod = {
      Environment     = "PROD"
      Name            = "devopscorner-terraform-prod-vpc"
      Department      = "DEVOPS"
      DepartmentGroup = "PROD-DEVOPS"
      ResourceGroup   = "PROD-VPC"
    }
  }
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
  default     = "resources/rds/terraform.tfstate"
}
