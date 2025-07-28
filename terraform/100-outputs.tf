#######################################
# ✅ VPC Outputs
#######################################
output "vpc" {
  description = "VPC information: ID, CIDR block, and DNS support"
  value = {
    id            = aws_vpc.ecs_vpc.id
    cidr_block    = aws_vpc.ecs_vpc.cidr_block
    dns_support   = aws_vpc.ecs_vpc.enable_dns_support
    dns_hostnames = aws_vpc.ecs_vpc.enable_dns_hostnames
  }
}

#######################################
# ✅ Subnet Outputs
#######################################
output "public_subnets" {
  description = "Public subnets with ID, AZ, and CIDR block"
  value = [
    for i in range(length(aws_subnet.public)) : {
      id         = aws_subnet.public[i].id
      az         = aws_subnet.public[i].availability_zone
      cidr_block = aws_subnet.public[i].cidr_block
    }
  ]
}

output "private_subnets" {
  description = "Private subnets with ID, AZ, and CIDR block"
  value = [
    for i in range(length(aws_subnet.private)) : {
      id         = aws_subnet.private[i].id
      az         = aws_subnet.private[i].availability_zone
      cidr_block = aws_subnet.private[i].cidr_block
    }
  ]
}

#######################################
# ✅ NAT Gateway + EIP Output
#######################################
output "nat_gateway" {
  description = "NAT Gateway ID and public IP"
  value = {
    id        = aws_nat_gateway.ecs_nat.id
    public_ip = aws_eip.nat_eip.public_ip
  }
}

#######################################
# ✅ IAM Roles for ECS Task Definitions
#######################################
output "ecs_task_execution_role_arn" {
  description = "IAM role ARN used by ECS to pull images/logs"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "IAM role for ECS task runtime access"
  value       = aws_iam_role.ecs_task_role.arn
}

#######################################
# ✅ ECS Cluster + Service Discovery Outputs
#######################################
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "service_discovery_namespace_id" {
  description = "Cloud Map namespace ID used for service discovery"
  value       = aws_service_discovery_private_dns_namespace.quote_namespace.id
}

output "quote_backend_sd_arn" {
  description = "Service Discovery ARN for quote-backend"
  value       = aws_service_discovery_service.quote_backend_sd.arn
}

output "quote_frontend_sd_arn" {
  description = "Service Discovery ARN for quote-frontend"
  value       = aws_service_discovery_service.quote_frontend_sd.arn
}

#######################################
# ✅ ECS Service Outputs
#######################################
output "ecs_service_name" {
  description = "ECS Fargate service name"
  value       = aws_ecs_service.quoteApp_service.name
}

#######################################
# ✅ Frontend Public URL Hint (Manual)
#######################################
output "quote_frontend_url_hint" {
  description = "Public URL to test the frontend manually (replace <PUBLIC_IP>)"
  value       = "http://<PUBLIC_IP>:80 — get from ECS Task → ENI → Public IP"
}
