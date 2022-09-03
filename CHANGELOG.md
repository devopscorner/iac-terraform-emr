# IaC Terraform EMR - v2.3.0

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- All features from version 2.2.0
- Added Documentation for CI/CD Pipeline with
  - Implementation Security Static Code Analysis for Terraform Plan
    - Tenable [`terrascan`](https://github.com/tenable/terrascan)
    - Terraform Plan Scanning with [`checkov`](https://github.com/bridgecrewio/checkov)
    - Terraform Version Manager with [`tfenv`](https://github.com/tfutils/tfenv)
    - Cloud Cost Estimate with [`infracost`](https://www.infracost.io/)
  - Implementation Infra Costing

- Sample Implementation
  ```
  # ========================= #
  #  Terraform Plan (Review)  #
  # ========================= #
  - terraform init
  - terraform workspace select ${WORKSPACE_ENV} || terraform workspace new ${WORKSPACE_ENV}
  - terraform plan --out tfplan.binary
  - terraform show -json tfplan.binary > tfplan.json

  # ================== #
  #  Terraform Addons  #
  # ================== #
  # ~ Terrascan ~
  - terrascan init
  - terrascan scan -o human

  # ~ Tfsec ~
  - tfsec .

  # ~ Checkov ~
  - checkov -f tfplan.json

  # ~ Infracost ~
  - infracost breakdown --path tfplan.json
  ```

---

# IaC Terraform EMR - v2.2.0

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- All features from version 2.1.0
- Update EMR version from 6.2.1 to 6.7.0

---

# IaC Terraform EMR - v2.1.0

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Added dockerhub container script for build, tag, push & pull
- Added infracost GitHub action
  - Core Infra
  - Cloud9
  - EC2 Airflow
  - EC2 Jumphost
  - EC2 PSQL
  - EMR
  - RDS EMRDB
  - DynamoDB `tfstate`

---

# IaC Terraform EMR - v2.0.0

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Refactoring building image terraform-emr
- Rebuild dockerfile configuration
- Refactoring terraform core & rds
- Refactoring bash script get dependencies terraform modules
- Refactoring ecr build, tag, push, pull for terraform-emr
- Added git-clone script for clone repository inside codebuild
- Refactoring Makefile pipeline run

---

# IaC Terraform EMR - v1.3

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Update subnet ip range from /24 (256 ips) to /20 (4096 ips)
- Added Python Spark Job (poc tested)

---

# IaC Terraform EMR - v1.2

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Update userdata installation
- Added badges

---

# IaC Terraform EMR - v1.1

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Added sample model data for running Spark Job
- Added script training model for running Spark Job with CSV & Database sources
- Added script to run Spark Job inside Amazon EMR cluster
  - Manual running `spark-submit`
  - Automation running `spark-submit`
  - Allocate specific  memory limit
- Added [DEMO](DEMO.md) Sequence Process

---

# IaC Terraform EMR - v1.0

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Fixing pipeline for fully automate terraform approval
- Separate buildspec for AWS CodeBuild integration with different stage of AWS CodePipeline
- Added manual approval for triggering AWS CodeBuild terraform apply
- Added manual approval for triggering AWS CodeBuild terraform destroy
- Refactoring makefile to simplify running container builder cicd & container terraform emr

---

# IaC Terraform EMR - v0.1

Provisioning Amazon EMR cluster using Terraform as Infrastructure-as-Code (IaC) tools

## Features

- Update infrastructure network mapping for subnet
