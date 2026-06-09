variable "region" {
  type = string
}
variable "aws_vpc_cidr" {
  type = string
}
variable "bucketname" {
  type = string
}
variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnets_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_desired" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "allocated_storage" {
  type = number
}

variable "instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}
variable "node_instance_type" {
  type = list(string)
}