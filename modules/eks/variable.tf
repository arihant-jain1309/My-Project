variable "cluster_name" {}
variable "cluster_version" {
  default = "1.27"
}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}

