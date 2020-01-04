aws_region = "ap-southeast-1"

aws_profile = "default"

shared_credentials_file = "~/.aws/credentials"

vpc_cidr_block = "10.10.0.0/16"

vpc_name = "default"

environment = "prod"

public_subnets = {
    ap-southeast-1a = "10.10.1.0/24"
    ap-southeast-1b = "10.10.2.0/24"
    ap-southeast-1c = "10.10.3.0/24"
}

private_subnets = {
    ap-southeast-1a = "10.10.4.0/24"
    ap-southeast-1b = "10.10.5.0/24"
    ap-southeast-1c = "10.10.6.0/24"
}
