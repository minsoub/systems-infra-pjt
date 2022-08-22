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

# EKSAutoscailerPolicy
resource "aws_iam_policy" "systems-eks-worker-node-autoscailer-policy" {
    name = "systems-eks-worker-node-autoscailer-policy"
    description = "Systems EKS Worker Node AutoScailer Policy"
    policy = <<POLICY
{
      "Version": "2012-10-17",
      "Statement": [
          {
            "Action": [
               "autoscaling:DescribeAutoScalingGroups",
               "autoscaling:DescribeAutoScalingInstances",
               "autoscaling:DescribeLaunchConfigurations",
               "autoscaling:DescribeTags",
               "autoscaling:SetDesiredCapacity",
               "autoscaling:TerminateInstanceInAutoScalingGroup",
               "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
          }
      ]
}    
POLICY
}

# ALBIngressControllerPolicy
resource "aws_iam_policy" "systems-eks-worker-node-albingresscontroller-policy" {
    name = "systems-eks-worker-node-albingresscontroller-policy"
    description = "Systems EKS Woerker Node Alb IngressController Policy"
    policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
     {
        "Effect": "Allow",
        "Action": [
           "acm:DescribeCertificate",
           "acm:ListCertificates",
           "acm:GetCertificate"
        ],
        "Resource": "*"
     },
     {
        "Effect": "Allow",
        "Action": [
           "ec2:AuthorizeSecurityGroupIngress",
           "ec2:CreateSecurityGroup",
           "ec2:CreateTags",
           "ec2:DeleteTags",
           "ec2:DeleteSecurityGroup",
           "ec2:DescribeAccountAttributes",
           "ec2:DescribeAddresses",
           "ec2:DescribeInstances",
           "ec2:DescribeInstanceStatus",
           "ec2:DescribeInternetGateways",
           "ec2:DescribeNetworkInterfaces",
           "ec2:DescribeSecurityGroups",
           "ec2:DescribeSubnets",
           "ec2:DescribeTags",
           "ec2:DescribeVpcs",
           "ec2:ModifyInstanceAttribute",
           "ec2:ModifyNetworkInterfaceAttribute",
           "ec2:RevokeSecurityGroupIngress"
        ],
        "Resource": "*"
     },
     {
        "Effect": "Allow",
        "Action": [
           "elasticloadbalancing:AddListenerCertificates",
           "elasticloadbalancing:AddTags",
           "elasticloadbalancing:CreateListener",
           "elasticloadbalancing:CreateLoadBalancer",
           "elasticloadbalancing:CreateRule",
           "elasticloadbalancing:CreateTargetGroup",
           "elasticloadbalancing:DeleteListener",
           "elasticloadbalancing:DeleteLoadBalancer",
           "elasticloadbalancing:DeleteRule",
           "elasticloadbalancing:DeleteTargetGroup",
           "elasticloadbalancing:DeregisterTargets",
           "elasticloadbalancing:DescribeListenerCertificates",
           "elasticloadbalancing:DescribeListeners",
           "elasticloadbalancing:DescribeLoadBalancers",
           "elasticloadbalancing:DescribeLoadBalancerAttributes",
           "elasticloadbalancing:DescribeRules",
           "elasticloadbalancing:DescribeSSLPolicies",
           "elasticloadbalancing:DescribeTags",
           "elasticloadbalancing:DescribeTargetGroups",
           "elasticloadbalancing:DescribeTargetGroupAttributes",
           "elasticloadbalancing:DescribeTargetHealth",
           "elasticloadbalancing:ModifyListener",
           "elasticloadbalancing:ModifyLoadBalancerAttributes",
           "elasticloadbalancing:ModifyRule",
           "elasticloadbalancing:ModifyTargetGroup",
           "elasticloadbalancing:ModifyTargetGroupAttributes",
           "elasticloadbalancing:RegisterTargets",
           "elasticloadbalancing:RemoveListenerCertificates",
           "elasticloadbalancing:RemoveTags",
           "elasticloadbalancing:SetIpAddressType",
           "elasticloadbalancing:SetSecurityGroups",
           "elasticloadbalancing:SetSubnets",
           "elasticloadbalancing:SetWebACL"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
           "iam:CreateServiceLinkedRole",
           "iam:GetServerCertificate",
           "iam:ListServerCertificates"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
           "cognito-idp:DescribeUserPoolClient"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
           "waf-regional:GetWebACLForResource",
           "waf-regional:GetWebACL",
           "waf-regional:AssociateWebACL",
           "waf-regional:DisassociateWebACL"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
           "tag:GetResources",
           "tag:TagResources"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
           "waf:GetWebACL"
        ],
        "Resource": "*"
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

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AutoScailerPolicy" {
    policy_arn = aws_iam_policy.systems-eks-worker-node-autoscailer-policy.arn
    role       = aws_iam_role.systems-eks-worker-node-role.name
}

resource "aws_iam_role_policy_attachment" "systems-eks-worker-node-AlbIngressControllerPolicy" {
    policy_arn = aws_iam_policy.systems-eks-worker-node-albingresscontroller-policy.arn
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
    instance_types = ["c5.2xlarge"]
    disk_size = 200

    labels = {
        "role" = "systems-eks-node-group"
    }

    scaling_config {
        desired_size = 8
        min_size     = 8
        max_size     = 16
    }

    depends_on = [
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonEC2ContainerRegistryReadOnly,
        aws_iam_role_policy_attachment.systems-eks-worker-node-CloudWatchLogsFullAccess,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AmazonRoute53FullAccess,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AutoScailerPolicy,
        aws_iam_role_policy_attachment.systems-eks-worker-node-AlbIngressControllerPolicy
    ]

    tags = {
        "Name" = "${aws_eks_cluster.systems-eks-cluster.name}-systems-eks-worker-node-group"
    }
}