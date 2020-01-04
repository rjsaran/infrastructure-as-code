# outputs produced at the end of a terraform apply:

# ID of base route table
output "public_route_table_id" {
    value = module.route_table_public.route_table_id
}