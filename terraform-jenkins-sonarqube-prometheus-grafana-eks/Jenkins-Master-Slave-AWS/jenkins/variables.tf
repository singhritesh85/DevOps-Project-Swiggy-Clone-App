########################################### variables to launch EC2 ############################################################
variable "region" {
  type = string
  description = "Provide the AWS Region into which VPC to be created"
}

variable "instance_count" {
  description = "Provide the Instance Count"
  type = number
}

variable "provide_ami" {
  description = "Provide the AMI ID for the EC2 Instance"
  type = map
}

#variable "vpc_security_group_ids" {
#  description = "Provide the security group Ids to launch the EC2"
#  type = list
#}

variable "subnet_id" {
  description = "Provide the Subnet ID into which EC2 to be launched"
  type = string
}

variable "cidr_blocks" {
  description = "Provide the CIDR Block range"
  type = list
}

variable "instance_type" {
  description = "Provide the Instance Type"
  type = list
}

variable "kms_key_id" {
  description = "Provide the KMS Key ID to Encrypt EBS"
  type = string
}

variable "name" {
  description = "Provide the name of the EC2 Instance"
  type = string
}

variable "env" {
  type = list
  description = "Provide the Environment for AWS Resources to be created"
}

######################################################### Variables to create ALB for Jenkins ################################################################

variable "application_loadbalancer_name" {
  description = "Provide the Application Loadbalancer Name"
  type = string
}
variable "internal" {
  description = "Whether the lodbalancer is internet facing or internal"
  type = bool
}
variable "load_balancer_type" {
  description = "Provide the type of the loadbalancer"
  type = string
}
variable "subnets" {
  description = "List of subnets for Loadbalancer"
  type = list
}
#variable "security_groups" {     ## Security groups are not supported for network load balancers
#  description = "List of security Groups for Loadbalancer"
#  type = list
#}
variable "enable_deletion_protection" {
  description = "To disavle or enable the deletion protection of loadbalancer"
  type = bool
}
variable "s3_bucket_exists" {
  description = "Create S3 bucket only if doesnot exists."
  type = bool
}
variable "access_log_bucket" {
  description = "S3 bucket to capture Application LoadBalancer"
  type = string
}
variable "prefix" {
  description = "Provide the s3 bucket folder name"
  type = string
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type = number
}
variable "enabled" {
  description = "To capture access log into s3 bucket or not"
  type = bool
}
variable "target_group_name" {
  description = "Provide Target Group Name for Application Loadbalancer"
  type = string
}
variable "instance_port" {    #### Don't apply when target_type is lambda
  description = "Instance Port on which Application will run"
  type = number
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
  description = "The protocol to use for routing traffic to the targets."
  type = string
}
variable "target_type_alb" {
  description = "Select the target type of the Application LoadBalancer"
  type = list
}
variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group."
  type = string
}
variable "load_balancing_algorithm_type" {
  description = "Determines how the load balancer selects targets when routing requests. Only applicable for Application Load Balancer Target Groups."
  type = list
}
variable "healthy_threshold" {
  description = "Provide healthy threshold in seconds, the number of checks before the instance is declared healthy"
  type = number
}
variable "unhealthy_threshold" {
  description = "Provide unhealthy threshold in seconds, the number of checks before the instance is declared unhealthy"
  type = number
}
variable "healthcheck_path" {
  description = "Provide the health check path"
  type = string
}
#variable "ec2_instance_id" {
#  description = "Provide the EC2 Instance ID which is to be attached to the Target Group"
#  type = list
#}
variable "timeout" {
  description = "Provide the timeout in seconds, the length of time before the check times out."
  type = number
}
variable "interval" {
  description = "The interval between checks."
  type = string
}
variable "ssl_policy" {
  description = "Select the SSl Policy for the Application Loadbalancer"
  type = list
}
variable "certificate_arn" {
  description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
  type = string
}
variable "type" {
  description = "The type of routing action."
  type = list
}
