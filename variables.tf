variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "vtkey"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_groups" {
  description = "Name of security group"
  default     = "sg-092e4bd6d90564b7d"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0de43e61758b7158c"
}

variable "subnet_id" {
  description = "vpc security group"
  default     = "subnet-0873340a5e525b481"
}
