module "eks_cluster" {
  source = "../module"

########################################### To create VPC, EKS Cluster and NodeGroup ##################################################

  vpc_cidr = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
  igw_name = var.igw_name
  natgateway_name = var.natgateway_name
  vpc_name = var.vpc_name

  eks_cluster = var.eks_cluster
  eks_iam_role_name = var.eks_iam_role_name
  node_group_name = var.node_group_name
  eks_nodegrouprole_name = var.eks_nodegrouprole_name    
  launch_template_name = var.launch_template_name
#  eks_ami_id = var.eks_ami_id
  instance_type = var.instance_type
  disk_size = var.disk_size
  ami_type = var.ami_type
  release_version = var.release_version
  kubernetes_version = var.kubernetes_version
  capacity_type = var.capacity_type
  env = var.env[0]
  ebs_csi_name = var.ebs_csi_name

  ebs_csi_version         = var.ebs_csi_version[3]
  addon_version_guardduty = var.addon_version_guardduty[0]
  addon_version_kubeproxy = var.addon_version_kubeproxy[3]
  addon_version_vpc_cni   = var.addon_version_vpc_cni[3]
  addon_version_coredns   = var.addon_version_coredns[3]

############################################### For RDS ##############################################################

#  count = var.db_instance_count
  identifier = var.identifier
  db_subnet_group_name = var.db_subnet_group_name
#  rds_subnet_group = var.rds_subnet_group
#  read_replica_identifier = var.read_replica_identifier  ###  read_replica_identifier = "${var.read_replica_identifier}-${count.index + 1}"
  allocated_storage = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
#  read_replica_max_allocated_storage = var.read_replica_max_allocated_storage
  storage_type = var.storage_type[0]
#  read_replica_storage_type = var.read_replica_storage_type
  engine = var.engine[3]             ### var.engine[0]  use for MySQL
  engine_version = var.engine_version[11]       ### var.engine_version[0]  use for MySQL
  instance_class = var.instance_class[0]
#  read_replica_instance_class = var.read_replica_instance_class
  rds_db_name = var.rds_db_name
  username = var.username
  password = var.password
  parameter_group_name = var.parameter_group_name[1]
  multi_az = var.multi_az[0]
#  read_replica_multi_az = var.read_replica_multi_az
#  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot[0]
#  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  availability_zone = var.availability_zone[0]  ### It should not be enabled for Multi-AZ option, If it is not enabled for Single DB Instance then it's value will be taken randomly.
  publicly_accessible = var.publicly_accessible[1]
#  read_replica_vpc_security_group_ids = var.read_replica_vpc_security_group_ids
#  backup_retention_period = var.backup_retention_period
  kms_key_id_rds = var.kms_key_id_rds
#  read_replica_kms_key_id = var.read_replica_kms_key_id
  monitoring_role_arn = var.monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

}

