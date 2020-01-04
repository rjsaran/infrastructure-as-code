# Classic Load Balancer
resource "aws_elb" "this" {
    name                      = var.name
    internal                  = var.internal

    security_groups           = var.security_groups
    subnets                   = var.subnets

    cross_zone_load_balancing   = var.cross_zone_load_balancing
    idle_timeout                = var.idle_timeout
    connection_draining         = var.connection_draining
    connection_draining_timeout = var.connection_draining_timeout

    dynamic "listener" {
        for_each = var.listener
        content {
            instance_port      = listener.value.instance_port
            instance_protocol  = listener.value.instance_protocol
            lb_port            = listener.value.lb_port
            lb_protocol        = listener.value.lb_protocol
            ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
        }
    }

    health_check {
        healthy_threshold   = lookup(var.health_check, "healthy_threshold")
        unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
        target              = lookup(var.health_check, "target")
        interval            = lookup(var.health_check, "interval")
        timeout             = lookup(var.health_check, "timeout")
    }

    tags = {
        Name        = var.name
        Environment = var.environment
        Tool        = "Terraform"
    }
}

# Attach instance to elb
resource "aws_elb_attachment" "this" {
    count    = length(var.instances)

    elb      = aws_elb.this.id

    instance = element(var.instances, count.index)
}