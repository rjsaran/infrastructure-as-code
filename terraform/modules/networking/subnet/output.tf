# outputs produced at the end of a terraform apply or terraform output:

# IDs of subnet
output "subnet_ids" {
    value = aws_subnet.subnet.*.id
}