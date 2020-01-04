# outputs produced at the end of a terraform apply or terraform output:

# IDs of the private subnet
output "private_subnet_ids" {
    value = module.subnet_private.subnet_ids
}
