# IaC Terraform EMR

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

![all contributors](https://img.shields.io/github/contributors/devopscorner/iac-terraform-emr)
![tags](https://img.shields.io/github/v/tag/devopscorner/iac-terraform-emr?sort=semver)
[![docker pulls](https://img.shields.io/docker/pulls/devopscorner/terraform-emr.svg)](https://hub.docker.com/r/devopscorner/terraform-emr/)
![download all](https://img.shields.io/github/downloads/devopscorner/iac-terraform-emr/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/iac-terraform-emr/2.3.0/total)
![view](https://views.whatilearened.today/views/github/devopscorner/iac-terraform-emr.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/iac-terraform-emr/blob/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/iac-terraform-emr)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/iac-terraform-emr)
![forks](https://img.shields.io/github/forks/devopscorner/iac-terraform-emr)
![stars](https://img.shields.io/github/stars/devopscorner/iac-terraform-emr)
[![license](https://img.shields.io/github/license/devopscorner/iac-terraform-emr)](https://img.shields.io/github/license/devopscorner/iac-terraform-emr)

---

## Available Tags

### Alpine

| Image name | Size |
|------------|------|
| `devopscorner/terraform-emr:alpine` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=alpine) |
| `devopscorner/terraform-emr:alpine-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/alpine-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=alpine-latest) |
| `devopscorner/terraform-emr:alpine-3.16` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/alpine-3.16.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=alpine-3.16) |

### Ubuntu

| Image name | Size |
|------------|------|
| `devopscorner/terraform-emr:ubuntu` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/ubuntu.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=ubuntu) |
| `devopscorner/terraform-emr:ubuntu-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/ubuntu-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=ubuntu-latest) |
| `devopscorner/terraform-emr:ubuntu-22.04` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/ubuntu-22.04.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=ubuntu-22.04) |

### AWS Linux (CodeBuild)

| Image name | Size |
|------------|------|
| `devopscorner/terraform-emr:latest`           | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=latest) |
| `devopscorner/terraform-emr:codebuild`        | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/codebuild.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=codebuild) |
| `devopscorner/terraform-emr:codebuild-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/codebuild-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=codebuild-latest) |
| `devopscorner/terraform-emr:codebuild-2.0`    | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/codebuild-2.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=codebuild-2.0) |
| `devopscorner/terraform-emr:codebuild-3.0`    | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/codebuild-3.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=codebuild-3.0) |
| `devopscorner/terraform-emr:codebuild-4.0`    | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/terraform-emr/codebuild-4.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/terraform-emr/tags?page=1&ordering=last_updated&name=codebuild-4.0) |

---

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)
- AWS Cli version 2 (`aws`)
- Terraform Cli (`terraform`)
- Terraform Environment (`tfenv`)

## Documentation

- Index Documentation, go to [this](docs/README.md) link
- Reproduce DEMO, detail [here](docs/DEMO.md)
- EMR DEMO Script, listed in `test` folder

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
