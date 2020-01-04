# outputs produced at the end of a terraform apply:

# VPC ID
output "vpc_id" { value = module.vpc.vpc_id }

# VPC Name
output "vpc_name" { value = var.vpc_name }

# VPC CIDR Block
output "vpc_cidr_block" { value = var.vpc_cidr_block }

# Internet Gateway ID
output "igw_id" { value = module.igw.igw_id }

# Public Subnets IDs
output "public_subnets" { value = module.subnet_public.public_subnet_ids }

# Private Subnets IDs
output "private_subnets" { value = module.subnet_private.private_subnet_ids }