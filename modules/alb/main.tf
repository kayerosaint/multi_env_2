data "aws_vpc" "dev_vpc" {
  tags = {
    Name = "dev"
  }
}

resource "aws_lb" "main" {
  name                       = "${var.project}-alb-${var.env}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.alb_sg
  subnets                    = var.public_subnets.*.id
  enable_deletion_protection = false

  tags = {
    Name        = "${var.project}-alb-${var.env}"
    Environment = var.env
  }
}

resource "aws_alb_target_group" "main" {
  name                 = "${var.project}-tg-${var.env}"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.dev_vpc.id
  target_type          = "ip"
  deregistration_delay = 10

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.project}-tg-${var.env}"
    Environment = var.env
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
}
