resource "aws_ecr_repository" "this" {
    name                 = var.name
    image_tag_mutability = var.image_tag_mutability

    image_scanning_configuration {
        scan_on_push = var.scan_on_push
    }

    tags = {
        Name        = "ecr-repository-${var.name}"
        Environment = var.environment
        Tool        = "Terraform"
    }
}