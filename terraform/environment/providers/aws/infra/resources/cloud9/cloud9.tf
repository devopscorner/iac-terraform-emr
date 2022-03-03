# ==========================================================================
#  Resources: Cloud9 / cloud9.tf (Cloud9 Configuration)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - VPC References
#    - Route53 Record
#    - Security Group
#    - Bootstrap Cloud9
# ==========================================================================

# --------------------------------------------------------------------------
#  Resources Tags
# --------------------------------------------------------------------------
locals {
  resources_tags = {
    Name          = "${var.cloud9_bucket_name}-${var.env[local.env]}",
    ResourceGroup = "${var.environment[local.env]}-CL9-DEVOPSCORNER"
  }
}

locals {
  ssh_pubkey = "${var.cloud9_ssh_public_key}" == "" ? file("~/.ssh/id_rsa.pub") : "${var.cloud9_ssh_public_key}"
  subnet_id  = "${var.env[local.env]}" == "lab" ? data.terraform_remote_state.core_state.outputs.ec2_public_1a[0] : data.terraform_remote_state.core_state.outputs.ec2_public_1b[0]
}

##########
# Cloud9 #
##########

data "aws_vpc" "selected" {
  id = data.terraform_remote_state.core_state.outputs.vpc_id
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

resource "random_string" "random" {
  length  = 12
  special = false
  lower   = true
  upper   = false
}

resource "aws_security_group" "cloud9_machine_firewall" {
  name   = "cloud9_machine_sg"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "${var.cloud9_my_ip}",
      data.terraform_remote_state.core_state.outputs.ec2_private_1a_cidr,
      data.terraform_remote_state.core_state.outputs.ec2_private_1b_cidr,
      data.terraform_remote_state.core_state.outputs.eks_private_1a_cidr,
      data.terraform_remote_state.core_state.outputs.eks_private_1b_cidr
    ]
    ipv6_cidr_blocks = ["::/0"]
    security_groups  = [data.terraform_remote_state.core_state.outputs.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, local.resources_tags)
}

resource "aws_security_group" "cloud9_efs_firewall" {
  name   = "cloud9_efs_sg"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    description     = "NFSv4"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.cloud9_machine_firewall.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, local.resources_tags)
}

resource "aws_efs_file_system" "cloud9_efs" {
  availability_zone_name = "${var.cloud9_efs_az[local.env]}"
  creation_token         = "cloud9_machine_files"

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.tags, local.resources_tags)
}

resource "aws_efs_access_point" "cloud9_efs_main_ap" {
  file_system_id = aws_efs_file_system.cloud9_efs.id
  posix_user {
    uid = 1000
    gid = 1000
  }

  root_directory {
    creation_info {
      owner_uid   = 1000
      owner_gid   = 1000
      permissions = 0755
    }
    path = "/data"
  }
}

resource "aws_efs_access_point" "cloud9_efs_docker_ap" {
  file_system_id = aws_efs_file_system.cloud9_efs.id
  posix_user {
    uid = 0
    gid = 0
  }

  root_directory {
    creation_info {
      owner_uid   = 0
      owner_gid   = 0
      permissions = 0755
    }
    path = "/docker"
  }
}

resource "aws_efs_mount_target" "cloud9_efs_mount" {
  file_system_id = aws_efs_file_system.cloud9_efs.id
  ## Public Subnet
  # data.terraform_remote_state.core_state.outputs.ec2_public_1a[0]
  # data.terraform_remote_state.core_state.outputs.ec2_public_1b[0]
  subnet_id       = local.subnet_id
  security_groups = [aws_security_group.cloud9_efs_firewall.id]
}

resource "aws_eip" "cloud9_machine_ip" {
  vpc = true
}

resource "aws_ssm_parameter" "cloud9_machine_ip" {
  name  = "cloud9_ip_allocation_id"
  type  = "String"
  value = aws_eip.cloud9_machine_ip.allocation_id
}

resource "aws_ssm_parameter" "cloud9_efs_az" {
  name  = "cloud9_efs_az"
  type  = "String"
  value = "${var.cloud9_efs_az[local.env]}"
}

resource "aws_ssm_parameter" "cloud9_efs" {
  name  = "cloud9_efs_id"
  type  = "String"
  value = aws_efs_file_system.cloud9_efs.id
}

resource "aws_ssm_parameter" "cloud9_efs_main_ap" {
  name  = "cloud9_efs_data_ap"
  type  = "String"
  value = aws_efs_access_point.cloud9_efs_main_ap.id
}

resource "aws_ssm_parameter" "cloud9_efs_docker_ap" {
  name  = "cloud9_efs_docker_ap"
  type  = "String"
  value = aws_efs_access_point.cloud9_efs_docker_ap.id
}

resource "aws_ssm_parameter" "cloud9_ssh_key" {
  name  = "cloud9_ssh_key"
  type  = "String"
  value = local.ssh_pubkey
}

data "aws_ami" "amzn_linux2" {
  owners      = ["amazon"]
  most_recent = "true"

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_instance_profile" "cloud9_ec2_profile" {
  name = "cloud9_instance_profile-${random_string.random.result}"
  role = aws_iam_role.cloud9_machine_role.name
}

resource "aws_key_pair" "cloud9_ssh_key" {
  key_name   = "cloud9_ssh_key"
  public_key = local.ssh_pubkey
}

resource "aws_spot_fleet_request" "cloud9_spot_request" {
  iam_fleet_role                      = aws_iam_role.cloud9_spot_fleet_role.arn
  spot_price                          = var.cloud9_spot_price
  allocation_strategy                 = "diversified"
  target_capacity                     = 1
  fleet_type                          = "maintain"
  on_demand_target_capacity           = 0
  instance_interruption_behaviour     = "terminate"
  terminate_instances_with_expiration = true
  wait_for_fulfillment                = true
  depends_on = [
    aws_efs_file_system.cloud9_efs,
    aws_efs_mount_target.cloud9_efs_mount,
    aws_efs_access_point.cloud9_efs_main_ap,
    aws_efs_access_point.cloud9_efs_docker_ap
  ]

  # similar with aws_instance
  launch_specification {
    key_name               = aws_key_pair.cloud9_ssh_key.id
    instance_type          = var.cloud9_instance_type
    ami                    = data.aws_ami.amzn_linux2.id
    spot_price             = var.cloud9_spot_price
    iam_instance_profile   = aws_iam_instance_profile.cloud9_ec2_profile.name
    subnet_id              = local.subnet_id
    vpc_security_group_ids = [aws_security_group.cloud9_machine_firewall.id]

    user_data = file("./userdata/user-data.sh")

  tags = merge(local.tags, local.resources_tags)
}

resource "aws_s3_bucket" "cloud9_main_bucket" {
  bucket = var.cloud9_bucket_name != "" ? var.cloud9_bucket_name : lower("cloud9-${random_string.random.result}")
  acl    = "private"
}
