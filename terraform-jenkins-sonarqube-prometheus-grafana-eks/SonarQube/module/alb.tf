#S3 Bucket to capture SonarQube ALB access logs
resource "aws_s3_bucket" "s3_bucket_sonarqube" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = var.access_log_bucket
  
  force_destroy = true

  tags = {
    Environment = var.env
  }
}

#S3 Bucket Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3bucket_encryption_sonarqube" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket_sonarqube[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

#Apply Bucket Policy to S3 Bucket
resource "aws_s3_bucket_policy" "s3bucket_policy_sonarqube" {
  count = var.s3_bucket_exists == false ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket_sonarqube[0].id
  policy = file("bucket-policy.json")
  
  depends_on = [aws_s3_bucket_server_side_encryption_configuration.s3bucket_encryption_sonarqube]
}

#################################################### SonarQube ALB #####################################################################

# Security Group for SonarQube ALB
resource "aws_security_group" "sonarqube_alb" {
  name        = "SonarQube-ALB-SecurityGroup"
  description = "Security Group for SonarQube ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = var.cidr_blocks
    from_port  = 80
    to_port    = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SonarQube-ALB-sg"
  }
}

#SonarQube Application Loadbalancer
resource "aws_lb" "sonarqube-application-loadbalancer" {
  name               = var.application_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.sonarqube_alb.id]           ###var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout = var.idle_timeout
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.prefix
    enabled = var.enabled
  }

  tags = {
    Environment = var.env
  }

  depends_on = [aws_s3_bucket_policy.s3bucket_policy_sonarqube]
}

#Target Group of SonarQube Application Loadbalancer
resource "aws_lb_target_group" "sonarqube_target_group" {
  name     = var.target_group_name
  port     = "9000"      ##### Don't use protocol when target type is lambda
  protocol = var.instance_protocol  ##### Don't use protocol when target type is lambda
  vpc_id   = var.vpc_id
  target_type = var.target_type_alb
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    path = "/"   #var.healthcheck_path     ###"/index.html"
    port = "traffic-port"
    protocol = "HTTP"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}

##SonarQube Application Loadbalancer listener for HTTP
resource "aws_lb_listener" "sonarqube_alb_listener_front_end_HTTP" {
  load_balancer_arn = aws_lb.sonarqube-application-loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.type[1]
    target_group_arn = aws_lb_target_group.sonarqube_target_group.arn
     redirect {    ### Redirect HTTP to HTTPS
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##SonarQube Application Loadbalancer listener for HTTPS
resource "aws_lb_listener" "sonarqube_alb_listener_front_end_HTTPS" {
  load_balancer_arn = aws_lb.sonarqube-application-loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.sonarqube_target_group.arn
  }
}

## EC2 Instance1 attachment to SonarQube Target Group
resource "aws_lb_target_group_attachment" "sonarqube_ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.sonarqube_target_group.arn
  target_id        = aws_instance.sonarqube.id               #var.ec2_instance_id[0]
  port             = var.instance_port
}

## EC2 Instance2 attachment to Target Group
#resource "aws_lb_target_group_attachment" "ec2_instance2_attachment_to_tg" {
#  target_group_arn = aws_lb_target_group.target_group.arn
#  target_id        = var.ec2_instance_id[1]
#  port             = var.instance_port
#}
