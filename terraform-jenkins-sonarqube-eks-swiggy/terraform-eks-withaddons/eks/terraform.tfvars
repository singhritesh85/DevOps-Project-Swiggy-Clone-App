###########Provide Parameters for EKS Cluster and NodeGroup########################

region = "us-east-2"

#prefix = eks


vpc_cidr = "10.10.0.0/16"
private_subnet_cidr = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
public_subnet_cidr = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
igw_name = "test-IGW"
natgateway_name = "EKS-NatGateway"
vpc_name = "test-vpc"


eks_cluster = "eks-demo-cluster"
eks_iam_role_name = "eks-iam-role"
node_group_name = "eks-nodegroup"
eks_nodegrouprole_name = "eks-nodegroup-role"
launch_template_name = "eks-launch-template"
#eks_ami_id = ["ami-0f5a11c59a157c25a", "ami-076fda1d45f0f46d7"]
instance_type = ["t3.micro", "t3.small", "t3.medium"]
disk_size = "10"
ami_type = ["AL2_x86_64", "CUSTOM"]
release_version = ["1.22.15-20221222", "1.23.16-20230217", "1.24.10-20230217", "1.25.6-20230217", "1.26.12-20240110", "1.27.9-20240110"]
kubernetes_version = ["1.22", "1.23", "1.24", "1.25", "1.26", "1.27"]
capacity_type = ["ON_DEMAND", "SPOT"]
env = [ "dev", "stage", "prod" ]
ebs_csi_name = "aws-ebs-csi-driver"
ebs_csi_version         = ["v1.28.0-eksbuild.1", "v1.27.0-eksbuild.1", "v1.26.1-eksbuild.1", "v1.25.0-eksbuild.1"]        #####"v1.21.0-eksbuild.1"
addon_version_guardduty = ["v1.4.1-eksbuild.2", "v1.4.0-eksbuild.1", "v1.3.1-eksbuild.1", "v1.2.0-eksbuild.3"]
addon_version_kubeproxy = ["v1.27.10-eksbuild.2", "v1.27.8-eksbuild.4", "v1.27.8-eksbuild.1", "v1.27.6-eksbuild.2"]
addon_version_vpc_cni   = ["v1.16.3-eksbuild.2", "v1.16.0-eksbuild.1", "v1.15.5-eksbuild.1", "v1.15.1-eksbuild.1"]
addon_version_coredns   = ["v1.10.1-eksbuild.7", "v1.10.1-eksbuild.6", "v1.10.1-eksbuild.5", "v1.10.1-eksbuild.4"]

############################################### RDS DB Instance Parameters ###############################################

  db_instance_count = 1
  identifier = "dbinstance-1"
  db_subnet_group_name = "rds-subnetgroup"        ###  postgresql-subnetgroup
#  rds_subnet_group = ["subnet-XXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX"]
#  read_replica_identifier = "dbinstance-readreplica-1"
  allocated_storage = 20
  max_allocated_storage = 100
#  read_replica_max_allocated_storage = 100
  storage_type = ["gp2", "gp3", "io1", "io2"]
#  read_replica_storage_type = ["gp2", "gp3", "io1", "io2"]
  engine = ["mysql", "mariadb", "mssql", "postgres"]
  engine_version = ["5.7.44", "8.0.33", "8.0.35", "8.0.36", "10.4.30", "10.5.20", "10.11.6", "10.11.7", "13.00.6435.1.v1", "14.00.3421.10.v1", "15.00.4365.2.v1", "14.9", "14.10", "14.11", "15.5", "16.1"] ### For postgresql select version = 14.9 and for MySQL select version = 5.7.44
  instance_class = ["db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
#  read_replica_instance_class = ["db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
  rds_db_name = "mydb"
  username = "postgres"   ### For MySQL select username as admin and For PostgreSQL select username as postgres
  password = "Admin123"          ### "Sonar123" use this password for PostgreSQL
  parameter_group_name = ["default.mysql5.7", "default.postgres14"]
  multi_az = ["false", "true"]   ### select between true or false
#  read_replica_multi_az = false   ### select between true or false
#  final_snapshot_identifier = "database-1-final-snapshot-before-deletion"   ### Here I am using it for demo and not taking final snapshot while db instance is deleted
  skip_final_snapshot = ["true", "false"]
#  copy_tags_to_snapshot = true   ### Select between true or false
  availability_zone = ["us-east-2a", "us-east-2b", "us-east-2c"]
  publicly_accessible = ["true", "false"]  #### Select between true or false
#  read_replica_vpc_security_group_ids = ["sg-038XXXXXXXXXXXXc291", "sg-a2XXXXXXca"]
#  backup_retention_period = 7   ### For Demo purpose I am not creating any db backup.
  kms_key_id_rds = "arn:aws:kms:us-east-2:02XXXXXXXXX6:key/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
#  read_replica_kms_key_id = "arn:aws:kms:us-east-2:027XXXXXXX06:key/20XXXXXXf3-aXXc-4XXd-9XX4-24XXXXXXXXXX17"  ### I am not using any read replica here.
  monitoring_role_arn = "arn:aws:iam::02XXXXXXXXX6:role/rds-monitoring-role"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]   ### ["audit", "error", "general", "slowquery"]  for MySQL







