variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}
variable "key_name" {

  description = "The name of the key pair to use for SSH access"

  type        = string

}
# variable "route_table_id" {

#   description = "The ID of the route table"

#   type        = string

# }
