output "bastion_ip" {
  value = module.bastion.bastion_public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
