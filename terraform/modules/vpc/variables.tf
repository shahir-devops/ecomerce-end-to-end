variable "aws_vpc_cidr" {
  type = string
}
variable "public_subnet_cidrs" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "private_subnets_cidr" {
  type = list(string)
}

variable "public_ami_id" {
  type = string
}
variable "public_instance_type" {
  type = string
}
variable "instance_public_name" {
  type = string
}
variable "install_tool_user_data" {
  type = string
}