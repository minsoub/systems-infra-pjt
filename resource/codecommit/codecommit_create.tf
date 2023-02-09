## CodeCommit Resource definition
# cms-app-web
resource "aws_codecommit_repository" "cms-app-web" {
    repository_name = "cms-app-web"
    description = "cms-app-web repository"
    default_branch =  "master"
}
# cms-app-api
resource "aws_codecommit_repository" "cms-app-api" {
    repository_name = "cms-app-api"
    description = "cms-app-api repository"
    default_branch =  "master"
}
# cms-gateway-api
resource "aws_codecommit_repository" "cms-gateway-api" {
    repository_name = "cms-gateway-api"
    description = "cms-agateway-api repository"
    default_branch =  "master"
}
# cms-mng-api
resource "aws_codecommit_repository" "cms-mng-api" {
    repository_name = "cms-mng-api"
    description = "cms-mng-api repository"
    default_branch =  "master"
}
# cms-batch-api
resource "aws_codecommit_repository" "cms-batch-api" {
    repository_name = "cms-batch-api"
    description = "cms-batch-api repository"
    default_branch =  "master"
}
# # internal-gateway-api
# resource "aws_codecommit_repository" "internal-gateway-api" {
#     repository_name = "internal-gateway-api"
#     description = "internal-agateway-api repository"
#     default_branch =  "master"
# }
# # external-gateway-api
# resource "aws_codecommit_repository" "external-gateway-api" {
#     repository_name = "external-gateway-api"
#     description = "external-agateway-api repository"
#     default_branch =  "master"
# }
# # inner-gateway-api
# resource "aws_codecommit_repository" "inner-gateway-api" {
#     repository_name = "inner-gateway-api"
#     description = "inner-agateway-api repository"
#     default_branch =  "master"
# }

#############################################################################
# codebuild IAM Role
# codebuild-cms-app-web-eks-dev-service-role
resource "aws_iam_role" "codebuild-cms-app-web-eks-dev-service-role" {
    name = "codebuild-cms-app-web-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-cms-app-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-cms-app-api-eks-dev-service-role" {
    name = "codebuild-cms-app-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-cms-gateway-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-cms-gateway-api-eks-dev-service-role" {
    name = "codebuild-cms-gateway-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-cms-mng-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-cms-mng-api-eks-dev-service-role" {
    name = "codebuild-cms-mng-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-cms-batch-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-cms-batch-api-eks-dev-service-role" {
    name = "codebuild-cms-batch-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-internal-gateway-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-internal-gateway-api-eks-dev-service-role" {
    name = "codebuild-internal-gateway-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-external-gateway-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-external-gateway-api-eks-dev-service-role" {
    name = "codebuild-external-gateway-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
# codebuild-inner-gateway-api-eks-dev-service-role
resource "aws_iam_role" "codebuild-inner-gateway-api-eks-dev-service-role" {
    name = "codebuild-inner-gateway-api-eks-dev-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
## codebuild에서 공통으로 사용할 Policy 
resource "aws_iam_policy" "CodeBuildVpcPolicy-eks-dev-policy" {
    name = "CodeBuildVpcPolicy-eks-dev-policy"
    description = "Systems CodeBuild VPC Policy - common"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateNetworkInterface",
                "ec2:DescribeDhcpOptions",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeVpcs"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateNetworkInterfacePermission"
            ],
            "Resource": "arn:aws:ec2:ap-northeast-2:807380035085:network-interface/*",
            "Condition": {
                "StringEquals": {
                    "ec2:Subnet": [
                        "arn:aws:ec2:ap-northeast-2:807380035085:subnet/subnet-04b370fb62ee7869c",
                        "arn:aws:ec2:ap-northeast-2:807380035085:subnet/subnet-0291f7df162a01c34"
                    ],
                    "ec2:AuthorizedService": "codebuild.amazonaws.com"
                }
            }
        }
    ]
} 
POLICY
}
## cms-app-web codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-cms-app-web-eks-dev" {
    name = "CodeBuildBasePolicy-cms-app-web-eks-dev"
    description = "Systems CodeBuild Base Policy - cms-app-web"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-app-web-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-app-web-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:cms-app-web"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/cms-app-web-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## cms-app-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-cms-app-api-eks-dev" {
    name = "CodeBuildBasePolicy-cms-app-api-eks-dev"
    description = "Systems CodeBuild Base Policy - cms-app-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-app-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-app-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:cms-app-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/cms-app-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## cms-mng-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-cms-mng-api-eks-dev" {
    name = "CodeBuildBasePolicy-cms-mng-api-eks-dev"
    description = "Systems CodeBuild Base Policy - cms-mng-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-mng-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-mng-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:cms-mng-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/cms-mng-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## cms-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-cms-gateway-api-eks-dev" {
    name = "CodeBuildBasePolicy-cms-gateway-api-eks-dev"
    description = "Systems CodeBuild Base Policy - cms-gateway-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-gateway-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-gateway-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:cms-gateway-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/cms-gateway-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## cms-batch-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-cms-batch-api-eks-dev" {
    name = "CodeBuildBasePolicy-cms-batch-api-eks-dev"
    description = "Systems CodeBuild Base Policy - cms-batch-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-batch-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/cms-batch-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:cms-batch-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/cms-batch-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## internal-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-internal-gateway-api-eks-dev" {
    name = "CodeBuildBasePolicy-internal-gateway-api-eks-dev"
    description = "Systems CodeBuild Base Policy - internal-gateway-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/internal-gateway-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/internal-gateway-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:internal-gateway-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/internal-gateway-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## external-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-external-gateway-api-eks-dev" {
    name = "CodeBuildBasePolicy-external-gateway-api-eks-dev"
    description = "Systems CodeBuild Base Policy - external-gateway-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/external-gateway-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/external-gateway-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:external-gateway-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/external-gateway-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
## inner-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_policy" "CodeBuildBasePolicy-inner-gateway-api-eks-dev" {
    name = "CodeBuildBasePolicy-inner-gateway-api-eks-dev"
    description = "Systems CodeBuild Base Policy - inner-gateway-api"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/inner-gateway-api-eks-dev-build",
                "arn:aws:logs:ap-northeast-2:807380035085:log-group:/aws/codebuild/inner-gateway-api-eks-dev-build:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-ap-northeast-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:codecommit:ap-northeast-2:807380035085:inner-gateway-api"
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:ap-northeast-2:807380035085:report-group/inner-gateway-api-eks-dev-build-*"
            ]
        }
    ]
}   
POLICY
}
####################################################################################################################
### cms-app-web attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "cms-app-web-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-web-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "cms-app-web-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-web-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-web-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-web-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-web-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
## cms-app-web codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "cms-app-web-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
## cms-app-web codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "cms-app-web-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-cms-app-web-eks-dev.arn
    role       = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### cms-app-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "cms-app-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "cms-app-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-app-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
## cms-app-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "cms-app-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
## cms-app-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "cms-app-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-cms-app-api-eks-dev.arn
    role       = aws_iam_role.codebuild-cms-app-api-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### cms-mng-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "cms-mng-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-mng-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "cms-mng-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-mng-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-mng-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-mng-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-mng-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
## cms-mng-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "cms-mng-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
## cms-mng-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "cms-mng-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-cms-mng-api-eks-dev.arn
    role       = aws_iam_role.codebuild-cms-mng-api-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### cms-gateway-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "cms-gateway-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-gateway-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "cms-gateway-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-gateway-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-gateway-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-gateway-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "cms-gateway-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
## cms-gateway-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "cms-gateway-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
## cms-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "cms-gateway-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-cms-gateway-api-eks-dev.arn
    role       = aws_iam_role.codebuild-cms-gateway-api-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### internal-gateway-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "internal-gateway-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "internal-gateway-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "internal-gateway-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "internal-gateway-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "internal-gateway-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "internal-gateway-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "internal-gateway-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
## internal-gateway-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "internal-gateway-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
## internal-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "internal-gateway-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-internal-gateway-api-eks-dev.arn
    role       = aws_iam_role.codebuild-internal-gateway-api-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### external-gateway-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "external-gateway-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "external-gateway-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "external-gateway-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "external-gateway-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "external-gateway-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "external-gateway-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "external-gateway-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
## external-gateway-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "external-gateway-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
## external-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "external-gateway-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-external-gateway-api-eks-dev.arn
    role       = aws_iam_role.codebuild-external-gateway-api-eks-dev-service-role.name
}
##################################################################################################################

####################################################################################################################
### inner-gateway-api attach
## systems common Policy Attach
resource "aws_iam_role_policy_attachment" "inner-gateway-api-codebuild-ecr-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-ecr-common-policy"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "inner-gateway-api-codebuild-eks-common-policy" {
    policy_arn = "arn:aws:iam::807380035085:policy/codebuild-eks-common-policy"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
## AWS 관리형 Policy 연결
resource "aws_iam_role_policy_attachment" "inner-gateway-api-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "inner-gateway-api-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "inner-gateway-api-CloudWatchLogsFullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "inner-gateway-api-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
resource "aws_iam_role_policy_attachment" "inner-gateway-api-AmazonRoute53FullAccess" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
## inner-gateway-api codebuild을 위한 공통 Policy (VPC Policy)
resource "aws_iam_role_policy_attachment" "inner-gateway-api-CodeBuildVpcPolicy" {
    policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-dev-policy.arn
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
## inner-gateway-api codebuild를 위한 고객관리형 Policy
resource "aws_iam_role_policy_attachment" "inner-gateway-api-CodeBuildBasePolicy" {
    policy_arn = aws_iam_policy.CodeBuildBasePolicy-inner-gateway-api-eks-dev.arn
    role       = aws_iam_role.codebuild-inner-gateway-api-eks-dev-service-role.name
}
##################################################################################################################

# # codebuild resource definition
# # cms-app-web-codebuild-dev
resource "aws_codebuild_project" "cms-app-web-codebuild-dev" {
    name        = "cms-app-web-codebuild-dev"
    description = "The CodeBuild project for cms-app-web application"
    service_role = aws_iam_role.codebuild-cms-app-web-eks-dev-service-role.arn
    build_timeout = "120"
    concurrent_build_limit = 1

    tags = {
        Name = "Creation by Terraform"
    }   

    source_version = "refs/heads/feature/CMS-PRJ"
    
    source {
        type = "CODECOMMIT"                 
        location = aws_codecommit_repository.cms-app-web.clone_url_http
        buildspec = "deploy/buildspec-eks-dev.yml"
        git_clone_depth = 1        
    }   

    environment {
        compute_type = "BUILD_GENERAL1_SMALL"
        image = "aws/codebuild/standard:3.0"
        type = "LINUX_CONTAINER"
        privileged_mode = "true"
        image_pull_credentials_type = "CODEBUILD"
    }

    vpc_config {
        vpc_id = "vpc-0c46c80eb059ca036"

        subnets = [
            "subnet-04b370fb62ee7869c",
            "subnet-0291f7df162a01c34",
        ]

        security_group_ids = [
            "sg-0cbc30ceb65f60a41",
        ]
    }

    artifacts {
        type = "NO_ARTIFACTS"
    }

    logs_config {
        cloudwatch_logs {
            group_name  = "log-group"
            stream_name = "log-stream"
        }
    }     
}
# cms-app-api-codebuild-dev

# cms-mng-api-codebuild-dev

# cms-gateway-api-codebuild-dev

# cms-batch-api-codebuild-dev

# internal-gateway-api-codebuild-dev

# external-gateway-api-codebuild-dev

# inner-gateway-api-codebuild-dev

######################################################################################################################
## CodePipeLine Service Role definition (공통으로 사용됨)
resource "aws_iam_role" "codepipeline-ap-northeast-2-systems-common-service-role" {
    name = "codepipeline-ap-northeast-2-systems-common-service-role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codepipeline.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}
## CodePipeLine에서 공통으로 사용할 Policy
## codebuild에서 공통으로 사용할 Policy 
resource "aws_iam_policy" "codepipeline-ap-northeast-2-systems-common-policy" {
    name = "codepipeline-ap-northeast-2-systems-common-policy"
    description = "Systems CodePipeLine Policy - common"
    policy = <<POLICY
{
    "Statement": [
        {
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEqualsIfExists": {
                    "iam:PassedToService": [
                        "cloudformation.amazonaws.com",
                        "elasticbeanstalk.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Action": [
                "codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetRepository",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codestar-connections:UseConnection"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "elasticbeanstalk:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "s3:*",
                "sns:*",
                "cloudformation:*",
                "rds:*",
                "sqs:*",
                "ecs:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "lambda:InvokeFunction",
                "lambda:ListFunctions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "opsworks:CreateDeployment",
                "opsworks:DescribeApps",
                "opsworks:DescribeCommands",
                "opsworks:DescribeDeployments",
                "opsworks:DescribeInstances",
                "opsworks:DescribeStacks",
                "opsworks:UpdateApp",
                "opsworks:UpdateStack"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "cloudformation:CreateStack",
                "cloudformation:DeleteStack",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:CreateChangeSet",
                "cloudformation:DeleteChangeSet",
                "cloudformation:DescribeChangeSet",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:SetStackPolicy",
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuildBatches",
                "codebuild:StartBuildBatch"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "devicefarm:ListProjects",
                "devicefarm:ListDevicePools",
                "devicefarm:GetRun",
                "devicefarm:GetUpload",
                "devicefarm:CreateUpload",
                "devicefarm:ScheduleRun"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "servicecatalog:ListProvisioningArtifacts",
                "servicecatalog:CreateProvisioningArtifact",
                "servicecatalog:DescribeProvisioningArtifact",
                "servicecatalog:DeleteProvisioningArtifact",
                "servicecatalog:UpdateProduct"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeImages"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "states:DescribeExecution",
                "states:DescribeStateMachine",
                "states:StartExecution"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "appconfig:StartDeployment",
                "appconfig:StopDeployment",
                "appconfig:GetDeployment"
            ],
            "Resource": "*"
        }
    ],
    "Version": "2012-10-17"
}
POLICY
}
## Policy attach in Role
resource "aws_iam_role_policy_attachment" "codepipeline-ap-northeast-2-systems-common-role-attach" {
    policy_arn = aws_iam_policy.codepipeline-ap-northeast-2-systems-common-policy.arn
    role       = aws_iam_role.ccodepipeline-ap-northeast-2-systems-common-service-role.name
}
######################################################################################################################
## CodePipeLine Resource definition
# cms-app-web-dev-pipeline
resource "aws_codepipeline" "cms-app-web-dev-pipeline" {
    name = "cms-app-web-dev-pipeline"
    role_arn = aws_iam_role.codepipeline-ap-northeast-2-systems-common-service-role.arn

    artifact_store {
        location = "codepipeline-ap-northeast-2-541478928876"
        type     = "S3"

        encryption_key {
        id   = aws_kms_key.default.arn
        type = "KMS"
        }
    }

    stage {
        name = "Source"

        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["source"]

            configuration = {
                RepositoryName = aws_codecommit_repository.cms-app-web.repository_name
                BranchName     = "feature/CMS-PRJ"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name             = "Build"
            category         = "Build"
            owner            = "AWS"
            provider         = "CodeBuild"

            configuration = {
                ProjectName = aws_codebuild_project.cms-app-web-codebuild-dev.name
            }
        }
    }
}
# cms-app-api-dev-pipeline

# cms-mng-api-dev-pipeline

# cms-gateway-api-dev-pipeline

# cms-batch-api-dev-pipeline

# internal-gateway-api-dev-pipeline

# external-gateway-api-dev-pipeline

# inner-gateway-api-dev-pipeline

