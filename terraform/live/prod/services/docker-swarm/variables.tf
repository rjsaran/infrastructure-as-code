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

# Swarm Discovery s3 Bucket variables
variable "s3_bucket_name" {
    description = "S3 Bucket for swarm discovery"
}

# Swarm Manger Variables
variable "manager_instance_type" {
    description = "Manager instance type"
    default     = "t2.small"
}

variable "min_managers" {
    description = "The minimum size of the auto scale group"
    default     = 3
}

variable "max_managers" {
    description = "The maximum size of the auto scale group"
    default     = 5
}

# Swarm Worker Variables
variable "worker_instance_type" {
    description = "Worker instance type"
    default     = "t2.medium"
}

variable "min_workers" {
    description = "The minimum size of the auto scale group"
    default     = 5
}

variable "max_workers" {
    description = "The maximum size of the auto scale group"
    default     = 9
}

# Environment Variable
variable "environment" {
    description = "Environment"
}