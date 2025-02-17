resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "order_api" {
  family             = "${var.environment}-order-api"
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 512
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "order-api",
      image = var.order_api_image,
      portMappings = [
      {
        containerPort = 8000  
        protocol      = "tcp"
        name          = "http" 
      }
    ],
      environment = [
        {
          name  = "ORDERS_TABLE_NAME"
          value = "${var.orders_table_name}"
        },
        {
          name  = "DYNAMODB_TABLE"
          value = var.orders_table_name
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        },
        {
          name  = "ORDER_PROCESSOR_URL"
          value = "http://order-processor.devopstht.internal:8000" 
        },
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.environment}-order-api"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "order-api"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "order_api" {
  name            = "${var.environment}-order-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.order_api.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.order_api.arn
    container_name   = "order-api"
    container_port   = 8000
  }

  service_connect_configuration {
    enabled   = true
    namespace = aws_service_discovery_private_dns_namespace.main.arn
    service {
      discovery_name = "order-api"
      port_name      = "http"
      client_alias {
        dns_name = "order-api.${var.environment}.internal"
        port     = 8000
      }
    }
  }

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  depends_on = [aws_ecs_task_definition.order_api,aws_ecs_service.order_processor]

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_ecs_task_definition" "order_processor" {
  family             = "${var.environment}-order-processor"
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 512
  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name  = "order-processor",
      image = var.processor_image,
      portMappings = [
      {
        containerPort = 8000  
        protocol      = "tcp"
        name          = "http" 
      }
    ],
      environment = [
        {
          name  = "INVENTORY_TABLE_NAME"
          value = "${var.inventory_table_name}"
        },
        {
          name  = "DYNAMODB_TABLE"
          value = "${var.inventory_table_name}"
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        }
      ],
       logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.environment}-order-processor"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "order-processor"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "order_processor" {
  name            = "${var.environment}-order-processor-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.order_processor.arn
  desired_count   = 1

  service_connect_configuration {
    enabled   = true
    namespace = aws_service_discovery_private_dns_namespace.main.arn
    service {
      discovery_name = "order-processor"
      port_name      = "http"
      client_alias {
        dns_name = "order-processor.${var.environment}.internal"
        port     = 8000
      }
    }
  }

   network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }
  depends_on = [aws_ecs_task_definition.order_processor]
}


resource "aws_cloudwatch_log_group" "order_api_logs" {
  name              = "/ecs/${var.environment}-order-api"
  retention_in_days = 7  # Adjust as needed
}

resource "aws_cloudwatch_log_group" "order_processor_logs" {
  name              = "/ecs/${var.environment}-order-processor"
  retention_in_days = 7  # Adjust as needed
}