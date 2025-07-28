#######################################
# ECS CLUSTER SECURITY GROUP
#######################################
resource "aws_security_group" "ecs_cluster_sg" {
  name   = "${var.project-name}-sg"
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "${var.project-name}-sg"
  }
}

#######################################
# INGRESS RULES FOR ECS
#######################################
resource "aws_security_group_rule" "ecs_ssh_in" {
  description       = "Allow SSH traffic from allowed_ingress_cidr"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ingress_cidr
  security_group_id = aws_security_group.ecs_cluster_sg.id
}
resource "aws_security_group_rule" "ecs_http_in" {
  description       = "Allow HTTP traffic from ALB"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_cluster_sg.id
}

resource "aws_security_group_rule" "ecs_https_in" {
  description       = "Allow HTTPS traffic from ALB"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_cluster_sg.id
}

#######################################
# EGRESS RULES FOR ECS
#######################################
resource "aws_security_group_rule" "ecs_all_out" {
  description       = "Allow all outbound traffic from ECS"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_cluster_sg.id
}