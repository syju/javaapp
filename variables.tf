variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "devops_test_key"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_groups" {
  description = "Name of security group"
  default     = "sg-0a575a5287e9325eb"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-07d59d159373b8030"
}

variable "subnet_id" {
  description = "vpc security group"
  default     = "subnet-061b09fcc31bf7201"
}
