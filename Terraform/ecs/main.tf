 resource "aws_ecs_cluster" "ecs_tc" {
  name = "ecs-tc"
  
}
resource "aws_ecs_task_definition" "ecs_tc_td" {
  family = "ecs_tc_td"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory= 512
  container_definitions = jsonencode([{
    name = "ecs_tc"
    image = "${var.image}:${locals.tag}"
    cpu = 256
    memory= 512
    portmappings = [{
      containerPort = 3000
      hostPort = 3000
    }]
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
    container_port = 3000
  }
  network_configuration {
    subnets = var.subnet_id_priv
    assign_public_ip = true
  }
  


}
  

 