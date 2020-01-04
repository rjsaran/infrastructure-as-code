# Bastion Security Group ID
output "security_group_id" {
    value = module.bastion_gateway.bastion_security_group_id
}