resource "aws_s3_bucket" "bucket" {
  bucket = var.bucketname
}
module "network" {
  source = "../modules/vpc"

  aws_vpc_cidr           = var.aws_vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnets_cidr   = var.private_subnets_cidr
  availability_zone      = var.availability_zone
  public_ami_id          = var.ami
  public_instance_type   = var.instance_type
  instance_public_name   = var.public_name
  install_tool_user_data = templatefile("${path.module}/install_tool.sh", {})
}

module "eks" {
  source = "../modules/eks"

  eks_cluster_name    = var.cluster_name
  cluster_version     = var.cluster_version
  private_subnet_ids  = module.network.private_subnet_ids
  public_subnet_ids   = module.network.public_subnet_ids
  node_desired_size   = var.node_desired
  node_min_size       = var.min_size
  node_max_size       = var.max_size
  nodes_instance_type = var.node_instance_type
}

module "database" {
  source = "../modules/rds"

  allocated_storage      = var.allocated_storage
  instance_class         = var.instance_class
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_identifier          = var.db_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  private_subnet_ids     = module.network.private_subnet_ids
  vpc_security_group_ids = [module.network.sg]
}
