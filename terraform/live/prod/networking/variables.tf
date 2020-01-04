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

# VPC Variables
variable "vpc_cidr_block" {}
variable "vpc_name" {}

# Public Subnet variables
variable "public_subnets" {
    type = map(string)
}

# Private Subnet variables
variable "private_subnets" {
    type = map(string)
}

# Environment Variable
variable "environment" {
    description = "Environment"
}