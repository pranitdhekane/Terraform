resource "aws_launch_template" "lt" {
  name_prefix   = "prod-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    security_groups             = [var.instance_sg_id]
    associate_public_ip_address = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG Instance"
    }
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "prod-tg"   # ⚠️ no underscore
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}


resource "aws_lb" "alb" {
  name               = "prod-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.alb_subnet_ids

  tags = {
    Name = "prod-alb"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_autoscaling_group" "asg" {
  name               = "prod-asg"
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1

  vpc_zone_identifier = var.subnet_ids   # ✅ private subnets

  target_group_arns = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  depends_on = [aws_lb_listener.listener]

  tag {
    key                 = "Name"
    value               = "autoscaling-instance"
    propagate_at_launch = true
  }
}