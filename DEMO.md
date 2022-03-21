# DEMO DevOpsCorner IaC Amazon EMR

## Deploy Container Image CI/CD

- Creating Dockerfile for Container Image CI/CD
- Creating Pipeline for Building Container Image CI/CD (`_infra/buildspec.yml`)
- Setup Varible Environment / Using Config Secret with AWS Parameter Store
- Running Pipeline with AWS CodePipeline & AWS CodeBuild
- Register Container Image CI/CD to Amazon ECR (Container Registry)

## Provisioning EMR using Terraform Inside Container CI/CD

- Creating Dockerfile for Container Terraform EMR
- Creating Pipeline for Build Container Image Terraform EMR (`_infra/buildspec.yml`)
- Setup Varible Environment / Using Config Secret with AWS Parameter Store
- Running Pipeline Build Container Image Terraform EMR
- Register Container Image Terraform EMR to Amazon ECR
- Creating Pipeline for Terraform Plan (`buildspec-emr-plan.yml`), Terraform Apply (`_infra/buildspec-emr-apply.yml`) & Terraform Destroy (`_infra/buildspec-emr-destroy.yml`)
- Create Manual Approval Pipeline for Apply
- Create Manual Approval Pipeline for Destroy
- Running Pipeline for Terraform Plan
- Running Pipeline for Terraform Apply (Auto Approved), after trigger Manual Approval Apply
- Running Pipeline for Terraform Destroy (Auto Approved), after trigger Manual Approval Destroy

## Running Spark Job

- Login to EMR Cluster (Master)
- Create Spark Job for Serial Mode
- Create Spark Job for Paralel Mode
- Running Spark Job
- Monitoring Spark Job in YARN Timeline Server
- Monitoring Spark Job in Spark History Server
