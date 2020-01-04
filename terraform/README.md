## Steps

- Ensure Machine images are created before running terraform. Create images using [packer](../packer/README.md).

- Create SSH key pair for ec2 instance in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "AWS EC2 Instance Key Pair" -f "ec2_instance_key"
    ```

- Create s3 bucket to store terraform state.
    ```
    terraform-state-2020-01-01
    ```
    If duplicate error occurs while creation, choose diffrent bucket name, need to replace terraform-state-2020-01-01 with new bucket name in this directory.

- Create AWS Key pair for ssh access.
    ```sh
    cd terraform/global/key_pair
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Create VPC, Public Subnets, Private Subnets, NAT Gateway, Internet Gateway, Route Table & Route Table Associations.
    ```sh
    cd terraform/live/prod/networking
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Create Bastion instances, ELB, Security Groups.
    ```sh
    cd terraform/live/mgmt/services/bastion-gateway
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Create Jenkins Master.
    ```sh
    cd terraform/live/mgmt/services/jenkins-master
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Need to manually setup SSH credentials of Jenkins slave and Docker Swarm cluster if Master is not able to connect to slaves ([Refer](../ansible/roles/jenkins-master/templates/setup_credentials.groovy.j2) for credentials information).

- Install Jenkins Plugins manually if skipped while packer AMI creation.

- Create Jenkins Slave.
    ```sh
    cd terraform/live/mgmt/services/jenkins-slave
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Create Docker Swarm Managers and Workers.
    ```sh
    cd terraform/live/prod/services/docker-swarm
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

- Create Elastic Container Registry for order service docker images.
    ```sh
    cd terraform/live/prod/data-storage/order-service-registry
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```