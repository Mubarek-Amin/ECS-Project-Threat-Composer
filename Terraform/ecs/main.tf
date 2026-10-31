 resource "aws_ecs_cluster" "ecs_tc" {
  name = "ecs-tc"
  
}
resource "aws_ecs_task_definition" "ecs_tc_td" {
  family = "ecs_tc_td"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory= 512
  execution_role_arn = var.exec_arn
  container_definitions = jsonencode([{
    name = "ecs_tc"
    image = "${var.image}:${var.image_tag}"
    cpu = 256
    memory= 512
    portMappings = [{
      containerPort = 80
      hostPort = 80
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group" = aws_cloudwatch_log_group.ecs_log.name
        "awslogs-region" = "us-east-1"
        "awslogs-stream-prefix" = "ecs"
      }

    }
  }])
}

resource "aws_ecs_service" "ecs_tc_service" {
  name = "ecs_tc_service"
  launch_type = "FARGATE"
  cluster = aws_ecs_cluster.ecs_tc.id
  task_definition = aws_ecs_task_definition.ecs_tc_td.arn
  desired_count = 2
  lifecycle {
    
  }
  load_balancer {
    target_group_arn = var.tg_arn
    container_name = "ecs_tc"
    container_port = 80
  }
  network_configuration {
    subnets = var.subnet_id_priv
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }
  


}
resource "aws_cloudwatch_log_group" "ecs_log" {
  name = "/ecs/ecs_tc"
  retention_in_days = 14
}
 

 