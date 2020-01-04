# Global variables
variable "aws_region" {
    description = "AWS region"
}

variable "aws_profile" {
     description = "AWS profile"
}

variable "shared_credentials_file" {
    description = "AWS credentials file path"
}

# Jenkins Slave Variables
variable "instance_type" {
    description = "Instance Type"
    default = "t2.micro"
}

variable "min_size" {
    description = "Minimum Size"
    default = 2
}

variable "max_size" {
    description = "Maximum Size"
    default = 3
}

variable "master_username" {
    description = "Master Jenkins username"
}

variable "master_password" {
    description = "Master Jenkins password"
}

variable "slave_credentials_id" {
    description = "Slaves SSH Credeneials ID"
}

variable "environment" {
    description = "Environment"
}