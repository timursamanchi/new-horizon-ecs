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


