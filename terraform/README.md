1. Create SSH key pair for ec2 instance in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "AWS EC2 Instance Key Pair" -f "ec2_instance_key"
    ```

2. Create s3 bucket to store terraform state.
    ```
    terraform-state-2020-01-01
    ```
    If duplicate error occurs while creation, choose diffrent bucket name, need to replace terraform-state-2020-01-01 with new bucket name in this directory.

3. Create AWS Key pair for ssh access.
    ```sh
    cd terraform/global/key_pair
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

4. Create VPC, Public Subnets, Private Subnets, NAT Gateway, Internet Gateway, Route Table & Route Table Associations.
    ```sh
    cd terraform/live/prod/networking
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

5. Change directory to prod/data-storage and run above commands to create AWS Elastic Container Registry.

6. Change directory to global/key_pair and run terraform commands to create AWS SSH Key Pair.