#######################################
# VPC Configuration
#######################################
variable "project-name" {
  description = "Project wide name prefix (used for tagging and naming all related AWS resources)"
  type        = string
  default     = "test-only-DELETE"
}
variable "ecs-cidr-block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/22" # divide the /22 block into 4 subnets of size /24, giving 256 IPs per subnet (254 usable).
}
variable "aws-region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-west-1" # Ireland
}