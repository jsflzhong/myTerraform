resource "aws_eks_cluster" "main" {
    name     = "main-cluster"
    role_arn = module.security.eks_role_arn
    vpc_config {
        subnet_ids = module.vpc.subnet_ids
        security_group_ids = [module.security.eks_security_group_id]
    }

    depends_on = [module.security.eks_role]
}
