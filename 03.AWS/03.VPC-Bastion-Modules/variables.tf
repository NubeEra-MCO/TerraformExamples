variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  default     = "ami-053b12d3152c0cc71"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "FirstEC2.pem"
}

variable "my_ip_cidr" {
  description = "Your IP address in CIDR format"
  default     = "49.36.101.33/32"

}

