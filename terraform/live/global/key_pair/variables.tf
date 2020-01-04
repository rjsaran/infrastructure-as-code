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

# Key Pair variables
variable "ssh_public_key_file" {
    description = "SSH public key file path"
    default     = "~/.ssh/ec2_instance_key.pub"
}