# Application Load Balancer
resource "aws_lb" "this" {
    name                      = var.name
    internal                  = var.internal

    security_groups           = var.security_groups
    subnets                   = var.subnets

    cross_zone_load_balancing = var.cross_zone_load_balancing

    tags = {
        Name        = var.name
        Environment = var.environment
        Tool        = "Terraform"
    }
}

resource "aws_lb_target_group" "this" {
    count       = length(var.target_groups)

    vpc_id      = var.vpc_id

    name        = var.target_groups[count.index]["name"]    
    port        = var.target_groups[count.index]["backend_port"]
    protocol    = var.target_groups[count.index]["backend_protocol"]
    target_type = var.target_groups[count.index]["target_type"]

    dynamic "health_check" {
        for_each = length(keys(lookup(var.target_groups[count.index], "health_check", {}))) == 0 ? [] : [lookup(var.target_groups[count.index], "health_check", {})]

        content {
            enabled             = health_check.value["enabled"]
            interval            = health_check.value["interval"]
            path                = health_check.value["path"]
            port                = health_check.value["port"]
            healthy_threshold   = health_check.value["healthy_threshold"]
            unhealthy_threshold = health_check.value["unhealthy_threshold"]
            timeout             = health_check.value["timeout"]
            protocol            = health_check.value["protocol"]
            matcher             = health_check.value["matcher"]
        }
    }

    depends_on = [aws_lb.this]

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name        = var.target_groups[count.index]["name"],
        Environment = var.environment
        Tool        = "Terraform"
    }
}

resource "aws_lb_listener" "frontend_http_tcp" {
    count = length(var.http_tcp_listeners)

    load_balancer_arn = aws_lb.this[0].arn

    port     = var.http_tcp_listeners[count.index]["port"]
    protocol = var.http_tcp_listeners[count.index]["protocol"]

    default_action {
        target_group_arn = aws_lb_target_group.this[lookup(var.http_tcp_listeners[count.index], "target_group_index", count.index)].id
        type             = "forward"
    }
}

resource "aws_lb_listener" "frontend_https" {
    count = length(var.https_listeners)

    load_balancer_arn = aws_lb.this[0].arn

    port     = var.https_listeners[count.index]["port"]
    protocol = var.https_listeners[count.index]["protocol"]

    certificate_arn = var.https_listeners[count.index]["certificate_arn"]
    ssl_policy      = var.https_listeners[count.index]["ssl_policy"]

    default_action {
        target_group_arn = aws_lb_target_group.this[lookup(var.http_tcp_listeners[count.index], "target_group_index", count.index)].id
        type             = "forward"
    }
}

resource "aws_lb_listener_certificate" "https_listener" {
    count = length(var.extra_ssl_certs)

    listener_arn    = aws_lb_listener.frontend_https[var.extra_ssl_certs[count.index]["https_listener_index"]].arn
    certificate_arn = var.extra_ssl_certs[count.index]["certificate_arn"]
}