#######################################
# ECS Fargate Service: quoteApp_service
# Two containers, no ALB, direct public access
#######################################

resource "aws_ecs_service" "quoteApp_service" {
  name            = "${var.project-name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.quoteApp_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }

  # ECS supports only ONE service discovery registry — use for backend
  service_registries {
    registry_arn   = aws_service_discovery_service.quote_backend_sd.arn
    container_name = "quote-backend"
    container_port = 8080
  }

  deployment_controller {
    type = "ECS"
  }

  tags = {
    Name = "${var.project-name}-ecsService"
  }
}
