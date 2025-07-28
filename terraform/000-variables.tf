#######################################
# VPC Configuration
#######################################
variable "project-name" {
  description = "Project wide name prefix (used for tagging and naming all related AWS resources)"
  type        = string
  default     = "test-only-DELETE"
}
variable "cidr-block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "aws-region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-west-1" # Ireland
}
#######################################
# Ingress Access Configuration Control
#######################################
variable "allowed-ingress-cidr" {
  description = "List of CIDR blocks allowed to access ECS services (SSH/HTTP/HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}