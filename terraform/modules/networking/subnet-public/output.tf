# outputs produced at the end of a terraform apply or terraform output:

# IDs of the public subnet
output "public_subnet_ids" {
    value = module.subnet_public.subnet_ids
}
