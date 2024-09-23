variable "region" {
  type = string
  description = "Provide the AWS Region into which EKS Cluster to be created"
}

variable "vpc_cidr"{
description = "Provide the CIDR for VPC"
type = string
#default = "10.10.0.0/16"
}

variable "private_subnet_cidr"{
description = "Provide the cidr for Private Subnet"
type = list
#default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "public_subnet_cidr"{
description = "Provide the cidr of the Public Subnet"
type = list
#default = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"]
}

data "aws_partition" "amazonwebservices" {
}

data "aws_region" "reg" {
}

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "G_Duty" {
}

variable "igw_name" {
description = "Provide the Name of Internet Gateway"
type = string
#default = "test-IGW"
}

variable "natgateway_name" {
description = "Provide the Name of NAT Gateway"
type = string
#default = "EKS-NatGateway"
}

variable "vpc_name" {
description = "Provide the Name of VPC"
type = string
#default = "test-vpc"
}




variable "eks_cluster" {
  type     = string
  description = "Provide the EKS Cluster Name"
}

variable "eks_iam_role_name" {
  type = string
  description = "Provide the EKS IAM Role Name"
}

variable "node_group_name" {
  type = string
  description = "Provide the Node Group Name"
}

variable "eks_nodegrouprole_name" {
  type = string
  description = "Provide the Node Group Role Name"
}

variable "launch_template_name" {
  type = string
  description = "Provide the Launch Template Name"
}

#variable "eks_ami_id" {
#  type = list
#  description = "Provide the EKS AMI ID"
#}

variable "instance_type" {
  type = list
  description = "Provide the Instance Type EKS Worker Node" 
}

variable "disk_size" {
  type = number
  description = "Provide the EBS Disk Size"
}

variable "capacity_type" {
  type = list
  description = "Provide the Capacity Type of Worker Node"
}

variable "ami_type" {
  type = list
  description = "Provide the AMI Type"
}

variable "release_version" {
  type = list
  description = "AMI version of the EKS Node Group"
}

variable "kubernetes_version" {
  type = list
  description = "Desired Kubernetes master version."
}

variable "env" {
  type = list
  description = "Provide the Environment for EKS Cluster and NodeGroup"
}

variable "ebs_csi_name" {
  type = string
  description = "Provide the addon name"
}

variable "ebs_csi_version" {
  type = list
  description = "Provide the ebs csi driver version"
}

variable "addon_version_guardduty" {
  type = list
  description = "Provide the addon version for Guard Duty"
}

variable "addon_version_kubeproxy" {
  type = list
  description = "Provide the addon version for kube-proxy"
}

variable "addon_version_vpc_cni" {
  type = list
  description = "Provide the addon version for VPC-CNI"
}

variable "addon_version_coredns" {
  type = list
  description = "Provide the addon version for core-dns"
}

########################################### Variables for RDS #########################################################

variable "identifier" {
  description = "Provide the DB Instance Name"
  type = string
}
variable "db_subnet_group_name" {
  description = "Provide the Name for DB Subnet Group"
  type = string
}
#variable "rds_subnet_group" {
#  description = "Provide the Subnet IDs to create DB Subnet Group"
#  type = list
#}
variable "db_instance_count" {
  description = "Provide the number of DB Instances to be launched"
  type = number
}
#variable "read_replica_identifier" {
#  description = "Provide the Read-Replica DB Instance Name"
#  type = string
#}
variable "allocated_storage" {
  description ="Memory Allocated for RDS"
  type = number
}
variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type = number
}
#variable "read_replica_max_allocated_storage" {
#  description = "The upper limit to which Amazon RDS Read Replica can automatically scale the storage of the DB instance"
#  type = number
#}
variable "storage_type" {
  description = "storage type of RDS"
  type = list
}
#variable "read_replica_storage_type" {
#  description = "storage type of RDS Read Replica"
#  type = string
#}
variable "engine" {
  description = "Engine of RDS"
  type = list
}
variable "engine_version" {
  description = "Engine Version of RDS"
  type = list
}
variable "instance_class" {
  description = "DB Instance Type"
  type = list
}
#variable "read_replica_instance_class" {
#  description = "DB Instance Type of Read Replica"
#  type = list
#}
variable "rds_db_name" {
  description = "Provide the DB Name"
  type = string
}
variable "username" {
  description = "Provide the DB Instance username"
  type = string
}
variable "password" {
  description = "Provide the Password of DB Instance"
  type = string
}
variable "parameter_group_name" {
  description = "Parameter Group Name for RDS"
  type = list
}
variable "multi_az" {
  description = "To enable or disable multi AZ"
  type = list
}
#variable "read_replica_multi_az" {
#  description = "To enable or disable multi AZ"
#  type = list
#}
#variable "final_snapshot_identifier" {
#  description = "Provide the Final Snapshot Name"
#  type = string
#}
variable "skip_final_snapshot" {
  description = "To skip Final Snapshot before deletion"
  type = list
}
#variable "copy_tags_to_snapshot" {
#  description = "Copy Tags to Final Snapshot"
#  type = list
#}
variable "availability_zone" {
  description = "Availabilty Zone of the RDS DB Instance"
  type = list
}
variable "publicly_accessible" {
  description = "To make RDS publicly Accessible or not"
  type = list
}
#variable "read_replica_vpc_security_group_ids" {
#  description = "List of VPC security groups to br associated with RDS Read Replica"
#  type = list
#}
#variable "backup_retention_period" {
#  description = "The days to retain backups for. Must be between 0 and 35"
#  type = list
#}
variable "kms_key_id_rds" {
  description = "ARN of Kms Key Id to encrypt the RDS Volume"
  type = string
}
#variable "read_replica_kms_key_id" {
#  description = "ARN of Kms Key Id to encrypt the RDS Volume of Read Replica"
#  type = string
#}
variable "monitoring_role_arn" {
  description = "ARN of IAM Role to enable enhanced monitoring"
  type = string
}
variable "enabled_cloudwatch_logs_exports" {
  description = "Which type of Logs to enable"
  type = list
}
