variable "region" {
  description = "aws region"
  type        = string
}

variable "image" {
  description = "container image you will run on the instance"
  type        = string
}

variable "task_cpu" {
  description = "cpu usage"
  type        = string
}

variable "task_memory" {
  description = "memory usage"
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
  description = "development"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default = [
    "eu-west-3a",
    "eu-west-3b"
  ]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default = [
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24"
  ]
}

variable "vpc_cidr_blocks" {
  description = "List of private subnets"
  type        = string
}

variable "container_port" {
  default = "4000"
  type    = string
}

variable "project" {
  description = "project name"
  default     = "PACMAN-XXX"
  type        = string
}

variable "vpc_id" {
  default = "dev"
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default = [
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24",
    "10.0.15.0/24",
    "10.0.16.0/24"
  ]
}
