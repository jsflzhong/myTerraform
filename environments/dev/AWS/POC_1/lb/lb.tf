resource "aws_lb" "main" {
    name               = "main-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups   = [module.security.lb_security_group_id]
    subnets            = module.vpc.subnet_ids
}

resource "aws_lb_target_group" "main" {
    name     = "main-target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
}
