variable "allocated_storage" {
  type    = number
  default = 20
}
variable "instance_class" {
  type    = string
  default = "db.t3.micro"
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
  type    = string
  default = "mysql"
}
variable "engine_version" {
  type    = string
  default = "8.4.8"
}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}