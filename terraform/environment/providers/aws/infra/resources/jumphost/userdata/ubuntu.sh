#!/bin/sh

export DEBIAN_FRONTEND=noninteractive

export ANSIBLE_VERSION=2.12.2
export PACKER_VERSION=1.7.10
export TERRAFORM_VERSION=1.1.6
export TERRAGRUNT_VERSION=v0.36.1

export DEBIAN_FRONTEND=noninteractive
export DOCKER_PATH="/usr/bin/docker"
export DOCKER_COMPOSE_PATH="/usr/bin/docker-compose"
export DOCKER_COMPOSE_VERSION="2.2.3"

# ================================================================================================
#  INSTALL USER-DATA (Ubuntu LINUX)
# ================================================================================================
apt -o APT::Sandbox::User=root update
apt-get update
apt-get install -y \
    git \
    bash \
    curl \
    wget \
    jq \
    apt-transport-https \
    ca-certificates \
    openssh-server \
    openssh-client \
    net-tools \
    vim-tiny \
    nano \
    zip \
    unzip \
    python3-minimal \
    python3-distutils \
    python3-pip \
    python3-apt \
    iputils-ping

# ================================================================================================
#  INSTALL DOCKER (Ubuntu Linux)
# ================================================================================================
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-cache policy docker-ce

apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    docker-ce

# ================================================================================================
#  INSTALL DOCKER-COMPOSE
# ================================================================================================
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) -o $DOCKER_COMPOSE_PATH
chmod +x /usr/bin/docker-compose

# ================================================================================================
#  INSTALL DevOps TOOLS
# ================================================================================================
## install awscli
apt-get install -y \
    awscli &&
    # install terraform
    wget -O terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
        https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin &&
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&
    # install terragrunt
    wget -O /usr/local/bin/terragrunt \
        https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 &&
    chmod +x /usr/local/bin/terragrunt &&
    # install packer
    wget -O packer_${PACKER_VERSION}_linux_amd64.zip \
        https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip &&
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin &&
    rm -f packer_${PACKER_VERSION}_linux_amd64.zip

python3 -m pip install pip==21.3.1 &&
    pip3 install --upgrade pip cffi &&
    # install ansible
    pip3 install ansible-core==${ANSIBLE_VERSION} \
        ansible-tower-cli==3.3.4 \
        PyYaml \
        Jinja2 \
        httplib2 \
        six \
        requests \
        boto3 &&
    # setup root .ssh directory
    mkdir -p /home/ubuntu/.ssh && chmod 0700 /home/ubuntu/.ssh && chown -R root. /home/ubuntu/.ssh

chmod +x /tmp/*.sh

# Cleanup Cache
apt-get clean &&
    apt-get autoremove -y

## Set Locale
echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

##### CUSTOMIZE ~/.profile #####
echo '' >>~/.profile
echo '### Docker ###
export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300' >> ~/.profile

## Adding Custom Sysctl
echo 'vm.max_map_count=524288' >> /etc/sysctl.conf
echo 'fs.file-max=131072' >> /etc/sysctl.conf
