output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
output "node_group_name" {
  value = aws_eks_node_group.node_groups.node_group_name
}