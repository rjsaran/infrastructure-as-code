provider "aws" {
    # The AWS region in which all resources will be created
    region = var.aws_region

    # Require a 2.x version of the AWS provider
    version = "~> 2.6"

    # shared_credentials_file = var.shared_credentials_file

    # AWS Profile
    profile = var.aws_profile
}

terraform {
    backend "s3" {
        encrypt = "true"
        bucket  = "terraform-state-2020-01-01"
        region  = "ap-southeast-1"
        key     = "prod/networking/terraform.tfstate"
    }

    # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
    # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
    required_version = "= 0.12.16"
}