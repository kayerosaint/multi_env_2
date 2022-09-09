
variable "ssh_key" {
  description = "public key path"
  type        = string
}

variable "instance_ami" {
  description = "AWS AMI"
  type        = string
}

variable "user" {
  description = "instance user"
  type        = string
}

variable "env" {
  default = "development"
}

variable "public_subnet_cidrs" {
  description = "List of private subnets"
  type        = list(string)
}

variable "webserver_sg_id" {
  description = "EC2 security group id"
  type        = string
}

variable "public_subnet_ids" {}

variable "availability_zones" {}

variable "vpc_cidr_blocks" {}

variable "private_subnets" {}

variable "aws_internet_gateway" {}

variable "aws_route_table" {}

variable "aws_route_table_association" {}
