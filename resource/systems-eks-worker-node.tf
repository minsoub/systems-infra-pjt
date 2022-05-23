# Worker Node

# EC2 IAM Role
resource "aws_iam_role" "systems-eks-worker-node-role" {
    name = "systems-eks-worker-node-role"

    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    POLICY
}

# 생성한 IAM Role에 Policy를 추가
resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

# Node Group을 생성
resource "aws_eks_node_group" "systems-eks-node-group" {
    cluster_name    = aws_eks_cluster.systems-eks-cluster.name
    node_group_name = "systems-eks-node-group"
    node_role_arn   = aws_iam_role.systems-eks-worker-node-role.arn
    subnet_ids = [
        aws_subnet.systems_dev_private_subnet1.id,
        aws_subnet.systems_dev_private_subnet2.id
    ]
    instance_types = ["t4g.2xlarge"]
    disk_size = 200

    labels = {
        "role" = "systems-eks-node-group"
    }

    scaling_config {
        desired_size = 2
        min_size     = 2
        max_size     = 5
    }

    depends_on = [
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEC2ContainerRegistryReadOnly,
    ]

    tags = {
        "Name" = "${aws_eks_cluster.systems-eks-cluster.name}-systems-eks-worker-node-group"
    }
}