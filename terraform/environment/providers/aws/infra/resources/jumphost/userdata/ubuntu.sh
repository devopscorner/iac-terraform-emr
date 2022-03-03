#!/bin/sh

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
    mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh

chmod +x /tmp/*.sh

# cleanup cache
apt-get clean &&
    apt-get autoremove -y

## Set Locale
echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment
