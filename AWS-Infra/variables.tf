variable "region" {}
variable "access_key"{
default = ""
}
variable "secret_key"{
default = ""
}
variable "vpc_config" {}
variable "security_group_config" {}
variable "subnet_config" {}
variable "internetGW_config" {}
variable "elastic_iP_config" {}
variable "natGW_config" {}
variable "route_table_config" {}
variable "route_table_association_config" {}
variable "eks_cluster_config" {}
variable "eks_nodegroup_config" {}
