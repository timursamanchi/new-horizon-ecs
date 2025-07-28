#######################################
# VPC setting 
#######################################
resource "aws_vpc" "ecs_vpc" {
  cidr_block = var.cidr-block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project-name}-vpc"
  }
}

# get AZ availability zone
data "aws_availability_zones" "available" {
  state = "available"
}