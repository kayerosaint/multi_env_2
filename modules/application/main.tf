#==========================local docker=========================#
/*
resource "docker_image" "multi_env" {
  name = var.image
}

resource "docker_container" "multi_env" {
  image = docker_image.multi_env.latest
  name  = "multi_env"
  env = [
    "PORT=4000",
  ]

  ports {
    internal = 4000
    external = 80
  }
  restart = "unless-stopped"
}
*/
#==========================local docker=========================#

#################################################################
#===========================ECS CLUSTER=========================#
#################################################################
locals {
  app_name = "web"
}

module "cluster" {
  source  = "../ecs_cluster"
  project = var.project
  env     = var.env
}

#=========================ECS roles==============================#

module "roles" {
  source = "../ecs_roles"
  env    = var.env
}

#=======================ECS Task Definition======================#

module "task_definition" {
  source                   = "../ecs_task_definition"
  env                      = var.env
  project                  = var.project
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = module.roles.execution_role_arn
  task_role_arn            = module.roles.task_role_arn
  container_definitions = [
    {
      name      = local.app_name
      image     = var.image
      essential = true
      links     = []

      volumesFrom = []
      mountPoints = []
      links       = []
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
  ]
}

#==================Application Load Balancer=======================#
data "aws_vpc" "dev_vpc" {
  tags = {
    Name = "dev"
  }
}

module "alb" {
  #count             = length(var.public_subnets)
  source            = "../alb"
  project           = var.project
  env               = var.env
  alb_sg            = var.alb_sg
  public_subnets    = var.public_subnets
  vpc_id            = data.aws_vpc.dev_vpc.id
  health_check_path = "/health_check"
}
