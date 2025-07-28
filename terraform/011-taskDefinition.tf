#######################################
# Task Definition: quoteApp task
# Two containers: frontend + backend
#######################################

resource "aws_ecs_task_definition" "quoteApp_task" {
  family                   = "${var.project-name}-taskDef"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "quote-backend"
      image     = "040929397520.dkr.ecr.eu-west-1.amazonaws.com/quote-backend:NH03"
      essential = true

      portMappings = [
        {
          containerPort = 8080,
          protocol      = "tcp"
        }
      ],

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.quote_backend.name,
          awslogs-region        = "eu-west-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    },
    {
      name      = "quote-frontend"
      image     = "040929397520.dkr.ecr.eu-west-1.amazonaws.com/quote-frontend:NH03"
      essential = true

      portMappings = [
        {
          containerPort = 80,
          protocol      = "tcp"
        }
      ],

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.quote_frontend.name,
          awslogs-region        = "eu-west-1",
          awslogs-stream-prefix = "ecs"
        }
      },

      environment = [
        {
          name  = "QUOTE_API_URL"
          value = "http://localhost:8080/quote"
        }
      ]
    }
  ])
}
