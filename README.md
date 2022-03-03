# IaC Terraform EMR

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)
- AWS Cli version 2 (`aws`)
- Terraform Cli (`terraform`)
- Terraform Environment (`tfenv`)

## Build Container CI/CD

- Clone Repository DevOpsCorner-CICD

  ```
  git clone https://github.com/devopscorner/devopscorner-container.git
  ```

- Replace "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID

  ```
  find ./ -type f -exec sed -i 's/YOUR_AWS_ACCOUNT/123456789012/g' {} \;
  ```

- Build Container CI/CD (Ubuntu)

  ```
  cd compose/docker/cicd-ubuntu
  docker build . -t devopscorner-cicd:ubuntu
  -- or --
  make build-cicd-ubuntu
  ```

- Build Container CI/CD (Alpine)

  ```
  cd compose/docker/cicd-alpine
  docker build . -t devopscorner-cicd:alpine
  -- or --
  make build-cicd-alpine
  ```

- Add Your Container Image Path in ECR
- Push Container CI/CD to ECR
  - ECR Login

    ```
    aws ecr get-login-password --region [AWS_REGION] | docker login --username AWS --password-stdin [ECR_PATH]
    ---
    aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
    ```

  - ECR Build

    ```
    docker tag devopscorner-cicd:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devops/cicd:ubuntu

    -- or --

    docker tag devopscorner-cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devops/cicd:alpine
    ```

  - ECR Push

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devops/cicd:ubuntu

    ## Ubuntu ##
    cd compose
    ./ecr-tag-ubuntu.sh
    ./ecr-push-ubuntu.sh

    -- or --

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devops/cicd:alpine

    ## Alpine ##
    cd compose
    ./ecr-tag-alpine.sh
    ./ecr-push-alpine.sh
    ```

## Terraform EMR

- Clone this repository

  ```
  git clone https://github.com/devopscorner/iac-terraform-emr.git
  ```

- Get Terraform Modules
  - Officials

    ```
    ./get-official.sh
    -- or --
    make sub-official
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
    terraform workspace select lab
    terraform plan
    terraform apply
    ```

- Provisioning your Terraform State (Remote State)
  - Goto `terraform/environment/providers/aws/tfstate`

    ```
    cd core
    terraform init
    terraform workspace select lab
    terraform plan
    terraform apply
    ```

- Provisioning Amazon EMR (existing infrastructure)
  - Goto `terraform/environment/providers/aws/infra/resources`

    ```
    cd emr
    terraform init
    terraform workspace select lab
    terraform plan
    terraform apply
    ---
    notes: you need to define your existing infra in variables.tf
    ```

- Provisioning Other Infra Resources
  - Goto `terraform/environment/providers/aws/infra/resources`
    - Budget

      ```
      cd budget
      ```

    - RDS (database)

      ```
      cd rds
      ```

    - Cloud9

      ```
      cd cloud9
      ```

    - Amazon Managed Workflows for Apache Airflow (MWAA)

      ```
      cd mwaa
      ```

  - Running Terraform

    ```
    terraform init
    terraform workspace select lab
    terraform plan
    terraform apply
    ```

## Using Cloud9 IDE

- Provisioning Cloud9 in EC2 onspot Instances

  ```
  aws cloud9 create-environment-ec2 --name example-env --description "environment" --instance-type t3.small --subnet-id subnet-id --automatic-stop-time-minutes 60 --owner-arn arn:aws:iam::123:user/User

  -- or --

  Go to `terraform/environment/providers/aws/infra/resources/cloud9` folder

  terraform init
  terraform workspace select lab
  terraform plan
  terraform apply
  ```

- Bootstrap CI/CD Tools Inside IDE

  ```
  git clone https://github.com/devopscorner/devopscorner-container.git
  make sub-all
  make tf-core
  make tf-emr
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

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET)
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
