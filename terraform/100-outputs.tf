#######################################
# ✅ VPC Outputs
#######################################
output "vpc" {
  description = "VPC information: ID, CIDR block, and DNS support"
  value = {
    id                  = aws_vpc.ecs_vpc.id
    cidr_block          = aws_vpc.ecs_vpc.cidr_block
    dns_support         = aws_vpc.ecs_vpc.enable_dns_support
    dns_hostnames       = aws_vpc.ecs_vpc.enable_dns_hostnames
  }
}

#######################################
# ✅ Subnet Outputs
#######################################
output "public_subnets" {
  description = "Public subnets with ID and CIDR block"
  value = [
    for i in range(length(aws_subnet.public)) : {
      id         = aws_subnet.public[i].id
      cidr_block = aws_subnet.public[i].cidr_block
      az         = aws_subnet.public[i].availability_zone
    }
  ]
}

output "private_subnets" {
  description = "Private subnets with ID and CIDR block"
  value = [
    for i in range(length(aws_subnet.private)) : {
      id         = aws_subnet.private[i].id
      cidr_block = aws_subnet.private[i].cidr_block
      az         = aws_subnet.private[i].availability_zone
    }
  ]
}

#######################################
# ✅ NAT Gateway ID and Elastic IP
#######################################
output "nat_gateway" {
  description = "NAT Gateway ID and public IP"
  value = {
    id        = aws_nat_gateway.ecs_nat.id
    public_ip = aws_eip.nat_eip.public_ip
  }
}

######################################
# ✅ ECS IAM taskRole and taskExecution-role
#######################################
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

######################################
# ✅ ECS cluster details
#######################################
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "service_discovery_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.quote_namespace.id
}

output "quote_backend_sd_arn" {
  value = aws_service_discovery_service.quote_backend_sd.arn
}

output "quote_frontend_sd_arn" {
  value = aws_service_discovery_service.quote_frontend_sd.arn
}
