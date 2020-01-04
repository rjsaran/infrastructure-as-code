# outputs produced at the end of a terraform apply:

# ID of base route table
output "private_route_table_id" {
    value = module.route_table_private.route_table_id
}