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

# Bastion Gateway Variables
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

variable "environment" {
    description = "Environment"
}