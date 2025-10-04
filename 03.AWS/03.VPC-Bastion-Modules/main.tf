provider "aws" {
  region = "ap-south-1"
}

# VPC Module
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zones   = ["ap-south-1a", "ap-south-1b"]
  key_name             = "FirstEC2"
}

# App Module
module "app" {
  source             = "./modules/app"
  ami                = "ami-053b12d3152c0cc71"
  instance_type      = "t2.micro"
  key_name           = "FirstEC2"
  private_subnets    = module.vpc.private_subnets
  public_subnets     = module.vpc.public_subnets
  availability_zones = module.vpc.availability_zones
  vpc_id             = module.vpc.vpc_id
  route_table_id     = module.vpc.route_table_id
  internet_gateway   = module.vpc.internet_gateway
  min_size           = 2
  max_size           = 4
}

module "bastion" {
  source        = "./modules/bastion" # Adjust the path if the module is located elsewhere
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]
  instance_type = var.bastion_instance_type
  ami           = var.bastion_ami
  key_name      = var.key_name
  my_ip_cidr    = var.my_ip_cidr
  # Include any other inputs the bastion module requires
}


