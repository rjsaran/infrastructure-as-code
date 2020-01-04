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

# Jenkins Master Variables
variable "instance_type" {
    description = "Instance Type"
    default = "t2.micro"
}

variable "environment" {
    description = "Environment"
}