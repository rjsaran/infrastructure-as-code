# Launch configuration
resource "aws_launch_configuration" "this" {
    image_id                    = var.image_id
    instance_type               = var.instance_type
    iam_instance_profile        = var.iam_instance_profile
    key_name                    = var.key_name
    security_groups             = var.security_groups
    user_data                   = var.user_data

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            volume_type           = lookup(root_block_device, "volume_type", null)
            volume_size           = lookup(root_block_device, "volume_size", null)
            delete_on_termination = lookup(root_block_device, "delete_on_termination", null)
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "this" {
    name                 = "asg_${aws_launch_configuration.this.name}"
    launch_configuration = aws_launch_configuration.this.name
    vpc_zone_identifier  = var.vpc_zone_identifier
    load_balancers       = var.load_balancers
    min_size             = var.min_size
    max_size             = var.max_size

    lifecycle {
        create_before_destroy = true
    }

    tag {
        key                 = "Name"
        value               = var.name
        propagate_at_launch = true
    }

    tag {
        key                 = "Environment"
        value               = var.environment
        propagate_at_launch = true
    }

    tag {
        key                 = "Tool"
        value               = "Terraform"
        propagate_at_launch = true
    }
}