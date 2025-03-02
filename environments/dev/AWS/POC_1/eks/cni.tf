resource "aws_eks_addon" "cilium" {
    cluster_name = aws_eks_cluster.main.name
    addon_name   = "cilium"
    addon_version = "v1.11.0"
    resolve_conflicts = "OVERWRITE"
}
