##############################Parameters to launch EC2#############################

region = "us-east-2"
instance_count = 1
provide_ami = {
  "us-east-1" = "ami-0a1179631ec8933d7"
  "us-east-2" = "ami-080e449218d4434fa"
  "us-west-1" = "ami-0e0ece251c1638797"
  "us-west-2" = "ami-086f060214da77a16"
}
subnet_id = "subnet-XXXXXXXXXXXXXXXXX"
#vpc_security_group_ids = ["sg-0XXXXXXXXXXXXX9"]
cidr_blocks = ["0.0.0.0/0"]
instance_type = [ "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge" ]
name = "SonarQube-Server"

kms_key_id = "arn:aws:kms:us-east-2:02XXXXXXXXX6:key/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"   ### Provide the ARN of KMS Key.

env = ["dev", "stage", "prod"]

################################Parameters to create ALB############################

application_loadbalancer_name = "SonarQube-ALB"
internal = false
load_balancer_type = "application"
subnets = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX"]
#security_groups = ["sg-05XXXXXXXXXXXXXXc"]  ## Security groups are not supported for network load balancer
enable_deletion_protection = false
s3_bucket_exists = false   ### Select between true and false. It true is selected then it will not create the s3 bucket. 
access_log_bucket = "s3bucketcapturealblogsonarqube" ### S3 Bucket into which the Access Log will be captured
prefix = "application_loadbalancer_log_folder"
idle_timeout = 60
enabled = true
target_group_name = "SonarQube"
instance_port = 9000
instance_protocol = "HTTP"          #####Don't use protocol when target type is lambda
target_type_alb = ["instance", "ip", "lambda"]
vpc_id = "vpc-XXXXXXXXXXXXXXXXX"
#ec2_instance_id = ""
load_balancing_algorithm_type = ["round_robin", "least_outstanding_requests"]
healthy_threshold = 2
unhealthy_threshold = 2
timeout = 3
interval = 30
healthcheck_path = "/"
ssl_policy = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
certificate_arn = "arn:aws:acm:us-east-2:02XXXXXXXXX6:certificate/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX"
type = ["forward", "redirect", "fixed-response"]

