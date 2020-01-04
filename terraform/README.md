1. Create SSH key pair for ec2 instance in ~/.ssh Directory.
    ```sh
    ssh-keygen -t rsa -m PEM -C "AWS EC2 Instance Key Pair" -f "ec2_instance_key"
    ```

2. Create s3 bucket to store terraform state.
    ```
    terraform-state-2020-01-01
    ```

3. Change directory to terraform/live/prod/networking and run following command to create VPC, Public Subnets, Private Subnets, NAT Gateway, Internet Gateway, Route Table & Route Table Associations.
    ```sh
    terraform init
    terraform plan --var-file=variable.tfvars
    terraform apply --var-file=variable.tfvars
    ```

4. Change directory to prod/data-storage and run above commands to create AWS Elastic Container Registry.

5. Change directory to global/key_pair and run terraform commands to create AWS SSH Key Pair.