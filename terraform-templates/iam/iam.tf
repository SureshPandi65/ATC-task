resource "aws_iam_role" "eks_cp" {
  name = "iam-role-ekscontrolplane"
  description = "Role used by EKS control plane"
  assume_role_policy = <<EOF
{
       "Version": "2012-10-17",
       "Statement": [
         {
          "Sid": "ekscontrolplane",
          "Effect": "Allow",
          "Principal": {
            "Service": "eks.amazonaws.com"
            },
          "Action": "sts:AssumeRole"
         }
       ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_clusterpolicy" {
  role = aws_iam_role.eks_cp.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" 
}

resource "aws_iam_role" "eks_ng" {
  name = "iam-role-eksnodegroup"
  description = "Role used by EKS Node groups"
  assume_role_policy = <<EOF
{
       "Version": "2012-10-17",
       "Statement": [
         {
          "Sid": "eksnodegroup",
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
            },
          "Action": "sts:AssumeRole"
         }
       ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_ng_01" {
  role = aws_iam_role.eks_ng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_ng_02" {
  role = aws_iam_role.eks_ng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_ng_03" {
  role = aws_iam_role.eks_ng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

output "eks_iam_rolearn" {
   value = aws_iam_role.eks_cp.arn
}

output "eks_wkng_rolearn" {
   value = aws_iam_role.eks_ng.arn
}




	
