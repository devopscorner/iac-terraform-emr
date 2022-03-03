# ==========================================================================
#  Core: variables.tf (Subnet)
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
  type = map(string)
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
#  Prefix Infra
# ------------------------------------
variable "myinfra" {
  type    = string
  default = "devopscorner-terraform"
}

# ------------------------------------
#  VPC
# ------------------------------------
variable "vpc_cidr" {
  type = map(string)
  default = {
    lab     = "16.0.0.0/16"
    staging = "32.0.0.0/16"
    prod    = "64.0.0.0/16"
  }
}

variable "vpc_cidr_secondary_a" {
  type = map(string)
  default = {
    lab     = "16.1.0.0/16"
    staging = "32.1.0.0/16"
    prod    = "64.1.0.0/16"
  }
}

variable "vpc_cidr_secondary_b" {
  type = map(string)
  default = {
    lab     = "16.2.0.0/16"
    staging = "32.2.0.0/16"
    prod    = "64.2.0.0/16"
  }
}

# ------------------------------------
#  Infra Prefix
# ------------------------------------
# EC2 Prefix
variable "ec2_prefix" {
  description = "EC2 Prefix Name"
  default     = "ec2"
}

# EKS Prefix
variable "eks_prefix" {
  description = "EKS Prefix Name"
  default     = "eks"
}

# ----------------------------------------------
#  NAT Gateway
# ----------------------------------------------
# NAT EC2 Prefix
variable "nat_ec2_prefix" {
  description = "NAT EC2 Prefix Name"
  default     = "natgw_ec2"
}

# NAT EKS Prefix
variable "nat_eks_prefix" {
  description = "NAT EKS Prefix Name"
  default     = "natgw_eks"
}

# ----------------------------------------------
#  Subnet
# ----------------------------------------------
## EC2 Private
variable "ec2_private_a" {
  type        = map(string)
  description = "Private subnet for EC2 zone 1a"
  default = {
    lab     = "16.0.8.0/24"
    staging = "32.0.8.0/24"
    prod    = "64.0.8.0/24"
  }
}

variable "ec2_private_b" {
  type        = map(string)
  description = "Private subnet for EC2 zone 1b"
  default = {
    lab     = "16.0.12.0/24"
    staging = "32.0.12.0/24"
    prod    = "64.0.12.0/24"
  }
}

## EC2 Public
variable "ec2_public_a" {
  type        = map(string)
  description = "Public subnet for EC2 zone 1a"
  default = {
    lab     = "16.0.16.0/24"
    staging = "32.0.16.0/24"
    prod    = "64.0.16.0/24"
  }
}

variable "ec2_public_b" {
  type        = map(string)
  description = "Public subnet for EC2 zone 1b"
  default = {
    lab     = "16.0.20.0/24"
    staging = "32.0.20.0/24"
    prod    = "64.0.20.0/24"
  }
}

## EKS Private
variable "eks_private_a" {
  type        = map(string)
  description = "Private subnet for EKS zone 1a"
  default = {
    lab     = "16.0.48.0/24"
    staging = "32.0.48.0/24"
    prod    = "64.0.48.0/24"
  }
}

variable "eks_private_b" {
  type        = map(string)
  description = "Private subnet for EKS zone 1b"
  default = {
    lab     = "16.0.64.0/24"
    staging = "32.0.64.0/24"
    prod    = "64.0.64.0/24"
  }
}

## EKS Public
variable "eks_public_a" {
  type        = map(string)
  description = "Public subnet for EKS zone 1a"
  default = {
    lab     = "16.0.72.0/24"
    staging = "32.0.72.0/24"
    prod    = "64.0.72.0/24"
  }
}

variable "eks_public_b" {
  type        = map(string)
  description = "Public subnet for EKS zone 1b"
  default = {
    lab     = "16.0.96.0/24"
    staging = "32.0.96.0/24"
    prod    = "64.0.96.0/24"
  }
}

# ----------------------------------------------
#  Routing Table
# ----------------------------------------------
# EC2 RT Prefix
variable "ec2_rt_prefix" {
  description = "NAT EC2 Routing Table Prefix Name"
  default     = "ec2_rt"
}

# EKS RT Prefix
variable "eks_rt_prefix" {
  description = "NAT EKS Routing Table Prefix Name"
  default     = "eks_rt"
}

# ----------------------------------------------
#  Internet Gateway
# ----------------------------------------------
# IGW Prefix
variable "igw_prefix" {
  description = "IGW Prefix Name"
  default     = "igw"
}

# IGW RT Prefix
variable "igw_rt_prefix" {
  description = "IGW Routing Table Prefix Name"
  default     = "igw_rt"
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
  default     = "core/terraform.tfstate"
}
