# Repository ARN
output "repository_arn" {
    value       = aws_ecr_repository.this.arn
}

#  Repository URL
output "repository_url" {
    value = aws_ecr_repository.this.repository_url
}


# Repository Name
output "repository_name" {
    value       = aws_ecr_repository.this.name
}

# Registry ID
output "registry_id" {
    value       = aws_ecr_repository.this.registry_id
}