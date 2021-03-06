resource "aws_alb" "main" {
  name            = "myapp-load-balancer"
  subnets         = var.pubsubnet-cidr
  security_groups = var.loadbalancer_sg
}

resource "aws_alb_target_group" "app" {
  name        = "myapp-target-group"
  port        = var.port_lb
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_por_alb
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

