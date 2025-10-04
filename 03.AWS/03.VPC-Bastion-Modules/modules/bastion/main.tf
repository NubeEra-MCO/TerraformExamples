resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access to the bastion host"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BastionSecurityGroup"
  }
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  security_groups = [aws_security_group.bastion_sg.name]
  # security_group_ids     = [module.vpc.bastion_sg_id] # Security group ID associated with bastion
  associate_public_ip_address = true  # Allow public IP for bastion if required
  
  tags = {
    Name = "Bastion"
  }
}
