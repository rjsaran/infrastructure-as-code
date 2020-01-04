# infrastructure-as-code

Infrastructure As code Using Ansible, Packer &amp; Terraform

## Pre-requisites

- Install following tools:
    1. [Terraform](https://www.terraform.io/downloads.html): For Infrastucture Provisioning
    2. [Packer](https://www.packer.io/intro/getting-started/install.html): For Image Building
    3. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html): For Image Configuration


## Getting Started
1. Clone repository
    ```sh
    git clone https://github.com/rjsaran/infrasturcture-as-code
    cd infrasturcture-as-code
    ```

2. Create An IAM Role with atleast following permissions.
    <p align="center">
        <img src="./images/infra_automation_iam_user.png">
    </p>

3. Download AWS access key and secret key for above user and store into ~/.aws/credentials.
    ```
    [default]
    aws_access_key_id=<AWS_ACCESS_KEY_ID>
    aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>
    ```

4. Create SSH key pair for ec2 instance in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "AWS EC2 Instance Key Pair" -f "ec2_instance_key"
    ```

5. Create s3 bucket to store terraform state.
    ```
    terraform-state-2020-01-01
    ```

6. Change directory to terraform/live/prod/networking and run following command to create VPC, Public Subnets, Private Subnets, NAT Gateway, Internet Gateway, Route Table & Route Table Associations.
    ```sh
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

7. Change directory to prod/data-storage and run above commands to create AWS Elastic Container Registry.

8. Change directory to global/key_pair and run terraform commands to create AWS SSH Key Pair.

9. Change directory to mgmt/services/bastion-gateway.

Note: all the code in this repo is used only for demonstration and teaching purposes and should not be used in production.s