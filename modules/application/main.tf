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
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = module.logs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = local.app_name
        }
      }
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

#===========================ECS SERVISE=============================#

module "service" {
  source                   = "../ecs_service"
  project                  = var.project
  env                      = var.env
  cluster_id               = module.cluster.id
  task_definition_arn      = module.task_definition.arn
  desired_count            = 2
  min_percent              = 50
  max_percent              = 300
  launch_type              = "FARGATE"
  scheduling_strategy      = "REPLICA"
  ecs_tasks                = var.ecs_tasks
  private_subnets          = var.private_subnets
  aws_alb_target_group_arn = module.alb.tg_arn
  container_port           = var.container_port
  container_name           = local.app_name
}

#===========================LOGS======================================#

module "logs" {
  source            = "../cloudwatch"
  env               = var.env
  project           = var.project
  retention_in_days = 90
}
