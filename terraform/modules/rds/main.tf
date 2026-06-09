resource "aws_db_subnet_group" "sub-grp" {
  name       = "shahir-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DB Subnet"
  }
}
resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  identifier           = var.db_identifier
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id
  engine               = var.engine
  engine_version       = var.engine_version
  multi_az             = false
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password

  skip_final_snapshot     = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  publicly_accessible     = true
  backup_retention_period = 0

  tags = {
    DB_identifier = "books"
  }
}
