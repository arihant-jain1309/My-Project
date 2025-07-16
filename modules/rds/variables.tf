variable "username" {}
variable "password" {
  sensitive = true
}

variable "db_sg_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

