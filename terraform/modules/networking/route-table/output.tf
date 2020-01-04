# outputs produced at the end of a terraform apply:

# ID of base route table
output "route_table_id" {
    value = aws_route_table.this.id
}