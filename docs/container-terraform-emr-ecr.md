# Terraform EMR - Amazon ECR (Elastic Container Registry)

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

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)

## Build Container Image

- Clone this repository

  ```
  git clone https://github.com/devopscorner/terraform-emr.git
  ```

- Replace "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID

  ```
  find ./ -type f -exec sed -i 's/YOUR_AWS_ACCOUNT/123456789012/g' {} \;
  ```

- Set Environment Variable

  ```
  export ALPINE_VERSION=3.16
  export UBUNTU_VERSION=22.04
  export CODEBUILD_VERSION=4.0

  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"
  export BASE_IMAGE="alpine"  ## alpine | ubuntu | codebuild
  export IMAGE="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr"
  export TAG="latest"
  ```

- Execute Build Image

  - Alpine

    ```
    docker build -f Dockerfile -t $IMAGE:alpine .

    -- or --

    # default: 3.16
    ./ecr-build.sh YOUR_AWS_ACCOUNT alpine Dockerfile ${ALPINE_VERSION}
    ./ecr-build.sh YOUR_AWS_ACCOUNT alpine Dockerfile.alpine 3.16

    -- or --

    # default: 3.16
    make build-tf-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

  - Ubuntu

    ```
    docker build -f Dockerfile -t $IMAGE:ubuntu .

    -- or --

    # default: 22.04
    ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile.ubuntu ${UBUNTU_VERSION}
    ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile.ubuntu 22.04

    -- or --

    # default: 22.04
    make build-tf-ubuntu ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

  - CodeBuild

    ```
    docker build -f Dockerfile -t $IMAGE:codebuild .

    -- or --

    # default: 4.0
    ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile ${CODEBUILD_VERSION}
    ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile.codebuild 4.0

    -- or --

    # default: 4.0
    make build-tf-codebuild ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

## Push Image to Amazon ECR (Elastic Container Registry)

- Create Image Tags

  - Alpine

    ```
    # default: alpine-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine-latest

    # version: 3.16
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine-3.16
    ```

  - Ubuntu

    ```
    # default: ubuntu-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu-latest

    # version: 22.04
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu-22.04
    ```

  - CodeBuild

    ```
    # default: latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:latest

    # version: codebuild-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild-latest

    # version: 4.0
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild-4.0
    ```

- Create Image Tags for Automation

  - Alpine

    ```
    # default: 3.16
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT alpine ${ALPINE_VERSION} CI_PATH=devopscorner/terraform-emr

    -- or --

    make tag-tf-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

  - Ubuntu

    ```
    # default: 22.04
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT ubuntu ${UBUNTU_VERSION} CI_PATH=devopscorner/terraform-emr

    -- or --

    make tag-tf-ubuntu ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

  - CodeBuild

    ```
    # default: 4.0
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT codebuild ${CODEBUILD_VERSION} CI_PATH=devopscorner/terraform-emr

    -- or --

    make tag-tf-codebuild ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/terraform-emr
    ```

- Push Image to **Amazon ECR** with Tags

  - Alpine

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine-latest
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:alpine-3.16

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT alpine CI_PATH="devopscorner/terraform-emr"

    -- or --

    make push-tf-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/terraform-emr"
    ```

  - Ubuntu

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu-latest
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:ubuntu-22.04

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT ubuntu CI_PATH="devopscorner/terraform-emr"

    -- or --

    make push-tf-ubuntu ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/terraform-emr"
    ```

  - CodeBuild

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:latest
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild-latest
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/terraform-emr:codebuild-4.0

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT codebuild CI_PATH="devopscorner/terraform-emr"

    -- or --

    make push-tf-codebuild ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/terraform-emr"
    ```
