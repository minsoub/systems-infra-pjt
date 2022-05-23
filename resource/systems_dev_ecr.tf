# ECR Repository creation.
# Repository Name : systems-api
# resource "aws_ecr_repository" "systems-api" {
#     name                 = "systems-api"
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# # Repository Name : systems-auth
# resource "aws_ecr_repository" "systems-auth" {
#     name                 = "systems-auth"
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# # Repository Name : systems-gateway
# resource "aws_ecr_repository" "systems-gateway" {
#     name                 = "systems-gateway"
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# # Repository Name : systems-polling
# resource "aws_ecr_repository" "systems-polling" {
#     name                 = "systems-polling"
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }