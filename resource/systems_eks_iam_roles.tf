
data "aws_partition" "current" {}
data "aws_caller_identity" "caller" {}
# data "aws_eks_cluster" "cluster" {
#     name = "systems-eks-cluster"
# }
data "tls_certificate" "cluster" {
    #url = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
    url = aws_eks_cluster.systems-eks-cluster.identity.0.oidc.0.issuer
}

locals {
    role_to_user_map = {
        external_admin = "admin"
        external_developer = "developer"
    }

    role_map_obj = [
        for role_name, user in local.role_to_user_map: {
            rolearn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.caller.account_id}:role/${role_name}"
            username = user
            groups = contains(tolist([user]), "admin") ? tolist(["system:masters"]) : tolist(["none"])
        }
    ]
}

resource "aws_iam_role" "external_admin" {
    name = "external_admin"

    #data = ["arn:aws:iam::${data.aws_caller_identity.caller.account_id}:user/dev-systems", "arn:aws:iam::${data.aws_caller_identity.caller.account_id}:role/systems-eks-uer-role"]

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    #AWS = [data] # var.assume_developer_role
                    AWS = ["arn:aws:iam::${data.aws_caller_identity.caller.account_id}:user/dev-systems", 
                            "arn:aws:iam::${data.aws_caller_identity.caller.account_id}:role/systems-eks-uer-role"]
                }
            },
        ]
    })

    inline_policy {
        name = "external_admin_policy"

        policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
                {
                    Action   = ["eks:DescribeCluster"]
                    Effect   = "Allow"
                    Resource = "*"
                },
            ]
        })
    }
}

resource "aws_iam_role" "external_developer" {
    name = "external_developer"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    AWS = ["arn:aws:iam::${data.aws_caller_identity.caller.account_id}:user/dev-systems", 
                            "arn:aws:iam::${data.aws_caller_identity.caller.account_id}:role/systems-eks-uer-role"]
                }
            },
        ]
    })

    inline_policy {
        name = "external_developer_policy"

        policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
                {
                    Action   = ["eks:DescribeCluster"]
                    Effect   = "Allow"
                    Resource = "*"
                },
            ]
        })
    }
}

resource "aws_iam_role" "eks-service-account-role" {
    name = "workload_sa"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = ["sts:AssumeRoleWithWebIdentity"]
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    Federated = aws_iam_openid_connect_provider.eks-cluster.arn
                }
            },
        ]
    })

    inline_policy {
        name = "eks_service_account_policy"

        policy = jsonencode({
            Version = "2012-10-17"
            Statement = [
                {
                    Action   = ["s3:GetBucket", "s3:GetObject", "s3:PutObject"]
                    Effect   = "Allow"
                    Resource = "*"
                },
            ]
        })
    }
}

# 

# create the IAM OIDC provider for the cluster
resource "aws_iam_openid_connect_provider" "eks-cluster" {
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = [data.tls_certificate.cluster.certificates[0].sha1_fingerprint]
    url             = aws_eks_cluster.systems-eks-cluster.identity.0.oidc.0.issuer   # data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

# service-account
resource "kubernetes_service_account" "eks-service-account" {
    metadata {
        name = "cluster-user-account"
        #namespace = var.eks-cluster-namespace-name

        annotations = {
            "eks.amazonas.com/role-arn" = aws_iam_role.eks-service-account-role.arn
        }
    }
}

# user authority
resource "kubernetes_role" "namespace-viewer" {
    metadata {
        name = "developer-viewer"
        #namespace = var.eks-cluster-namespace-name
    }
    rule {
        api_groups = [""]
        resources  = ["pods", "pods/logs", "pods/attach", "pods/exec", "pods/exec", "services", "serviceaccounts", "configmaps", "persistentvolumes", "persistentvolumeclaims", "secrets"]
        verbs      = ["get", "list", "watch", "describe"]
    }
    rule {
        api_groups = ["apps"]
        resources  = ["deployments", "daemonsets", "statefulsets"]
        verbs      = ["get", "list", "watch", "describe"]
    }
    rule {
        api_groups = ["batch"]
        resources  = ["cronjobs", "jobs"]
        verbs      = ["get", "list", "watch", "describe"]
    }
}

resource "kubernetes_role_binding" "namespace-viewer" {
    metadata {
        name = "developer-viewer"
        #namespace = var.eks-cluster-namespace-name
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "Role"
        name      = kubernetes_role.namespace-viewer.metadata[0].name
    }
    subject {
        kind      = "User"
        name      = "developer"
        api_group = "rbac.authorization.k8s.io"
    }
}