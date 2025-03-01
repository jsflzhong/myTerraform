resource "aws_launch_configuration" "eks_nodes" {
    name_prefix   = "eks-node-"
    image_id      = "ami-eks-AMI-1"
    instance_type = "m5.4xlarge"
    security_groups = [module.security.eks_security_group_id]
    user_data = <<-EOT
                #!/bin/bash
                set -o xtrace
                /etc/eks/bootstrap.sh --apiserver-endpoint ${aws_eks_cluster.main.endpoint} --b64-cluster-ca ${aws_eks_cluster.main.certificate_authority[0].data}
                EOT
}

resource "aws_autoscaling_group" "eks_nodes" {
    desired_capacity     = 50
    max_size             = 100
    min_size             = 1
    launch_configuration = aws_launch_configuration.eks_nodes.id
    vpc_zone_identifier  = module.vpc.subnet_ids
}
