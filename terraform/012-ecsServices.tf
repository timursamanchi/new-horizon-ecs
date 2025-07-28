#######################################
# ECS Fargate Service: quoteApp_service
# Direct public IP access — NO Load Balancer
#######################################
resource "aws_ecs_service" "quoteApp_service" {
  name            = "${var.project-name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.quoteApp_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.public_subnets
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }

  # NOTE: ECS supports only one service discovery registry per service.
  # Use this only if needed for backend discovery via namespace
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


