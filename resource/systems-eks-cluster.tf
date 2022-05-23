# IAM Role 생성
resource "aws_iam_role" "systems-eks-cluster-role" {
    name = "systems-eks-cluster-role"

    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    POLICY
}

# 위에서 생성한 IAM Role에 policy를 추가한다.
resource "aws_iam_role_policy_attachment" "systems-eks-cluster-AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.systems-eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-cluster-AmazonEKSVPCResourceController" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role       = aws_iam_role.systems-eks-cluster-role.name
}

# Security Group 
resource "aws_security_group" "systems-ekc-cluster-sg" {
    name        = "systems-ekc-cluster-sg"
    description = "Cluster communication with worker nodes"
    vpc_id      = aws_vpc.systems_dev_vpc.id

    egress {
        from_port = 0
        to_port   = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "systems-eks-cluster-sg"
    }
}
# Security Group의 ingress Rule add
# resource "aws_security_group_rule" "" {
#     cidr_blocks =  xxxx
#     description = "Allow workstation to communicate with the cluster API Server"
#     from_port   = 443
#     protocol    = "tcp"
#     security_group_id = aws_security_group.systems-ekc-cluster-sg.id
#     to_port     = 443
#     type        = "ingress"
# }

# Cluster 생성
resource "aws_eks_cluster" "systems-eks-cluster" {
    name     = var.eks-cluster-name
    role_arn = aws_iam_role.systems-eks-cluster-role.arn
    version  = "1.21"

    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

    vpc_config {
        security_group_ids = [aws_security_group.systems-ekc-cluster-sg.id]
        subnet_ids = [
            aws_subnet.systems_dev_public_subnet1.id, 
            aws_subnet.systems_dev_public_subnet2.id,
            aws_subnet.systems_dev_private_subnet1.id,
            aws_subnet.systems_dev_private_subnet2.id
        ]
        endpoint_private_access = true
        endpoint_public_access = true
    }
    depends_on = [
        aws_iam_role_policy_attachment.systems-eks-cluster-AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.systems-eks-cluster-AmazonEKSVPCResourceController,
    ]
}