provider "aws" {
  region = var.aws_region
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = ["${var.security_groups}"]
  tags= {
    Name = var.tag_name
  }
}
