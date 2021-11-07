resource "aws_eks_cluster" "prod-eks" {
     name = var.eks_cluster_name 
     role_arn = var.eks_iam_rolearn
     vpc_config {
         endpoint_private_access = true
         endpoint_public_access = true
         subnet_ids = [var.pubsubnet01-id,var.pubsubnet02-id,var.privsubnet01-id,var.privsubnet02-id,]
         security_group_ids = [var.eks-control-sg-id]
     }

}

resource "aws_eks_node_group" "eks_wkg01" {
   cluster_name = aws_eks_cluster.prod-eks.name
   node_group_name = var.eks_wkng01_name
   node_role_arn = var.eks_wkng_rolearn
   subnet_ids = [var.pubsubnet01-id,var.pubsubnet02-id]
   scaling_config {
      desired_size = 1
      max_size     = 1
      min_size     = 1
   }
   ami_type = "AL2_x86_64"
   capacity_type = "ON_DEMAND"
   disk_size = "10"
   instance_types = ["t3.medium"]
}

