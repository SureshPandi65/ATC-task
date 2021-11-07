variable "eks_cluster_name" {
    description = "Name of the EKS cluster"
    default = "eks-aps1-terraform"
}

variable "kubernetes_version" {
   description = "kubernetes version"
}

variable "eks_iam_rolearn" {
    description = "ARN of the IAM role used by the EKS cluster control-plane"
}

variable "pubsubnet01-id" {
    description = "Public subnet01 ID"
}

variable "pubsubnet02-id" {
   description = "Public subnet02 ID"
}

variable "privsubnet01-id" {
   description = "Private subnet01 ID"
}

variable "privsubnet02-id" {
   description = "Private subnet02 ID"
}

variable "eks-control-sg-id" {
   description = "ID of the security group used by EKS control plane"
}

variable "eks_wkng01_name" {
    default = "eks-ng-aps1-linux01"
}

variable "eks_wkng_rolearn" {
  description = "ARN of the IAM role used by the EKS worker nodegroups"
}


