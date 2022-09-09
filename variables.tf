variable "region" {
  description = "aws region"
  type        = string
}

variable "image" {
  description = "container image you will run on the instance"
  type        = string
}

variable "instance_ami" {
  description = "AWS AMI"
  type        = string
}

variable "instance_user" {
  description = "instance user"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of public subnets"
  type        = list(string)
  default = [
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24",
  ]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "vpc_cidr_blocks" {
  description = "List of private subnets"
  type        = string
}
