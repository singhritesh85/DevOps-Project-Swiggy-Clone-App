########################################################## SonarQube Security Group #######################################################

# Security Group for SonarQube Server
resource "aws_security_group" "sonarqube" {
  name        = "SonarQube"
  description = "Security Group for SonarQube Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["10.10.0.0/16"]
  }

  ingress {
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    security_groups  = [aws_security_group.sonarqube_alb.id]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SonarQube-Server-sg"
  }
}

############################################################# SonarQube Server ###########################################################################

resource "aws_instance" "sonarqube" {
  ami           = var.provide_ami
  instance_type = var.instance_type
  monitoring = true
  vpc_security_group_ids = [aws_security_group.sonarqube.id]  ### var.vpc_security_group_ids       ###[aws_security_group.all_traffic.id]
  subnet_id = var.subnet_id                                 ###aws_subnet.public_subnet[0].id
  root_block_device{
    volume_type="gp2"
    volume_size="20"
    encrypted=true
    kms_key_id = var.kms_key_id
    delete_on_termination=true
  }
  user_data = file("user_data_sonarqube.sh")

  lifecycle{
    prevent_destroy=false
    ignore_changes=[ ami ]
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  metadata_options { #Enabling IMDSv2
    http_endpoint = "enabled"
    http_tokens   = "required"
    http_put_response_hop_limit = 2
  }

  tags={
    Name=var.name
    Environment = var.env
  }
}
resource "aws_eip" "eip_associate_sonarqube" {
  domain = "vpc"     ###vpc = true
}
resource "aws_eip_association" "eip_association_sonarqube" {  ### I will use this EC2 behind the ALB.
  instance_id   = aws_instance.sonarqube.id
  allocation_id = aws_eip.eip_associate_sonarqube.id
}
