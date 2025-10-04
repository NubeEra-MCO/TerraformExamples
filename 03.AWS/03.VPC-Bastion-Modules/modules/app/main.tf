# Security group for ALB
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ALB
resource "aws_lb" "app" {
  name               = "app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets
}

# Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# Bastion Host
resource "aws_instance" "bastion" {
  ami           = "ami-053b12d3152c0cc71"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[0]
  key_name      = var.key_name
  tags = {
    Name = "BastionHost"
  }
}

# Launch Configuration for ASG
resource "aws_launch_configuration" "app" {
  name           = "app-launch-config"
  image_id       = var.ami
  instance_type  = var.instance_type
  key_name       = var.key_name
  security_groups = [aws_security_group.alb_sg.id]
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  launch_configuration = aws_launch_configuration.app.name
  vpc_zone_identifier  = var.private_subnets
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.min_size
  target_group_arns    = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "AppInstance"
    propagate_at_launch = true
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway
}
