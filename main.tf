
module "networking" {
  source             = "./modules/networking"
  env                = "development"
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  vpc_cidr_blocks    = var.vpc_cidr_blocks
}

module "instance" {
  source             = "./modules/instance"
  ssh_key            = module.ssh.public_key_openssh
  user               = var.instance_user
  instance_ami       = var.instance_ami
  availability_zones = var.availability_zones
  vpc_cidr_blocks    = var.vpc_cidr_blocks
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  webserver_sg_id    = module.networking.webserver_sg_id
  public_subnet_ids  = module.networking.public_subnet_ids
  #==>>++just_for_tests++<<==
  aws_internet_gateway        = module.networking.aws_internet_gateway
  aws_route_table             = module.networking.aws_route_table
  aws_route_table_association = module.networking.aws_route_table_association
  #==>>++just_for_tests++<<==
}

module "security_groups" {
  source         = "./modules/security_groups"
  project        = "${var.project}-${var.env}"
  vpc_id         = module.networking.vpc_id
  container_port = var.container_port
}

module "ssh" {
  source = "./modules/ssh"
  env    = var.env
}

#==========================2nd phase install=================================#
module "application" {
  source = "./modules/application"
  #>>>+++ECS+++<<<#
  project        = var.project
  env            = var.env
  task_cpu       = var.task_cpu
  task_memory    = var.task_memory
  image          = var.image
  container_port = var.container_port
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
  ecs_tasks      = [module.security_groups.ecs_tasks]
  alb_sg         = [module.security_groups.alb_sg]
  #>>>+++ECS+++<<<#
  #==========================local docker====================================#
  #image = var.image
  #host  = "ssh://${var.instance_user}@${module.instance.my_static_ips[0]}:22"
  #==========================local docker====================================#
}
#==========================2nd phase install=================================#
