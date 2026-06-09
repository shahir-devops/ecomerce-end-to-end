variable "eks_cluster_name" {
    type = string
}
variable "cluster_version" {
  type = string
}
variable "private_subnet_ids"{
    type = list(string)
}
variable "public_subnet_ids"{
    type = list(string)
}

variable "nodes_instance_type" {
  type = list(string)
  default = [ "t3.medium" ]
}
variable "node_desired_size" {
  type = number
}
variable "node_min_size" {
  type = number
}
variable "node_max_size" {
    type= number
}