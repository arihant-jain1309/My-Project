variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

variable "bucket_name" {}

variable "cluster_name" {}
variable "cluster_version" {}

variable "db_user" {}
variable "db_pass" {
  sensitive = true
}

