# IaC Terraform EMR

![all contributors](https://img.shields.io/github/contributors/devopscorner/iac-terraform-emr)
![tags](https://img.shields.io/github/v/tag/devopscorner/iac-terraform-emr?sort=semver)
[![docker pulls](https://img.shields.io/docker/pulls/devopscorner/terraform-emr.svg)](https://hub.docker.com/r/devopscorner/terraform-emr/)
[![docker image size](https://img.shields.io/docker/image-size/devopscorner/iac-terraform-emr.svg?sort=date)](https://hub.docker.com/r/devopscorner/terraform-emr/)
![download all](https://img.shields.io/github/downloads/devopscorner/iac-terraform-emr/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/iac-terraform-emr/2.0/total)
![view](https://views.whatilearened.today/views/github/devopscorner/iac-terraform-emr.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/iac-terraform-emr/blob/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/iac-terraform-emr)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/iac-terraform-emr)
![forks](https://img.shields.io/github/forks/devopscorner/iac-terraform-emr)
![stars](https://img.shields.io/github/stars/devopscorner/iac-terraform-emr)
[![license](https://img.shields.io/github/license/devopscorner/iac-terraform-emr)](https://img.shields.io/github/license/devopscorner/iac-terraform-emr)

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)
- AWS Cli version 2 (`aws`)
- Terraform Cli (`terraform`)
- Terraform Environment (`tfenv`)

## Build Container CI/CD

- Read full documentation, go to [this](https://github.com/devopscorner/devopscorner-container/blob/main/README.md) link.

## Terraform EMR

- Clone this repository

  ```
  git clone https://github.com/devopscorner/iac-terraform-emr.git
  ```

- Get Terraform Modules
  - Officials

    ```
    ./get-officials.sh
    -- or --
    make sub-officials
    ```

  - Community

    ```
    ./get-community.sh
    -- or --
    make sub-community
    ```

  - Get All Modules (Officials & Community)

    ```
    make sub-all
    ```

- Provisioning your Infra (non existing infrastructure)
  - Goto `terraform/environment/providers/aws/infra`

    ```
    cd core
    terraform init
    terraform workspace select staging
    terraform plan
    terraform apply
    ```

- Provisioning your Terraform State (Remote State)
  - Goto `terraform/environment/providers/aws/tfstate`

    ```
    cd core
    terraform init
    terraform workspace select staging
    terraform plan
    terraform apply
    ```

- Provisioning Amazon EMR (existing infrastructure)
  - Goto `terraform/environment/providers/aws/infra/resources`

    ```
    cd emr
    terraform init
    terraform workspace select staging
    terraform plan
    terraform apply
    ---
    notes: you need to define your existing infra in variables.tf
    ```

- Provisioning Other Infra Resources
  - Read provisioning other infra resources, go to [this](https://github.com/devopscorner/terraform-infra/blob/master/docs/README.md) link.

## Terraform EMR Inside Container

- ECR Build

  - Example:

      ```
      # Alpine

      docker build . -t YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine
      ```

  - With Script:

      ```
      make build-tf-emr ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
      ```


- ECR Tag

  - Example:

      ```
      # Alpine

      docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:latest
      ```

  - With Script:

      ```
      make tag-tf-emr ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
      ```

- ECR Push

  - Example:

      ```
      # Alpine

      docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine

      # Latest (Alpine)

      docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:latest
      ```

  - With Script:

      ```
      make push-tf-emr ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
      ```

## Using Cloud9 IDE

- Provisioning Cloud9 in EC2 onspot Instances

  ```
  aws cloud9 create-environment-ec2 --name example-env --description "environment" --instance-type t3.small --subnet-id subnet-id --automatic-stop-time-minutes 60 --owner-arn arn:aws:iam::123:user/User

  -- or --

  Go to `terraform/environment/providers/aws/infra/resources/cloud9` folder

  terraform init
  terraform workspace select staging
  terraform plan
  terraform apply
  ```

## Cleanup

- Destroy Environment Lab

  ```
  terraform destroy
  ```

## Tested Environment

### Versioning

- Docker version

  ```
  docker version

  Client:
  Cloud integration: v1.0.22
  Version:           20.10.12
  API version:       1.41
  Go version:        go1.16.12
  Git commit:        e91ed57
  Built:             Mon Dec 13 11:46:56 2021
  OS/Arch:           darwin/amd64
  Context:           default
  Experimental:      true
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  Docker Compose version v2.2.3
  ```

- AWS Cli

  ```
  aws -v
  ---
  Note: AWS CLI version 2, the latest major version of the AWS CLI, is now stable and recommended for general use. For more information, see the AWS CLI version 2 installation instructions at: <https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html>
  ```

- Terraform Cli

  ```
  terraform version
  ---
  Terraform v1.1.6
  on darwin_amd64
  - provider registry.terraform.io/hashicorp/aws v3.74.3
  - provider registry.terraform.io/hashicorp/local v2.1.0
  - provider registry.terraform.io/hashicorp/null v3.1.0
  - provider registry.terraform.io/hashicorp/random v3.1.0
  - provider registry.terraform.io/hashicorp/time v0.7.2
  ```

- Terraform Environment Cli

  ```
  tfenv -v
  ---
  tfenv 2.2.2
  ```

## Security Check

Make sure that you didn't push sensitive information in this repository

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET_KEY)
- [ ] AWS Account ID
- [ ] AWS Resources ARN
- [ ] Username & Password
- [ ] Private (id_rsa) & Public Key (id_rsa.pub)
- [ ] DNS Zone ID
- [ ] APP & API Key

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
