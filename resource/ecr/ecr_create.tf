# ECR Repository creation.
## SMART ADMIN
# Repository Name : systems-auth-api-dev-repo
resource "aws_ecr_repository" "systems-auth-api-dev-repo" {
    name                 = "systems-auth-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : systems-auth-api-prod-repo
resource "aws_ecr_repository" "systems-auth-api-prod-repo" {
    name                 = "systems-auth-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : systems-chat-api-dev-repo
resource "aws_ecr_repository" "systems-chat-api-dev-repo" {
    name                 = "systems-chat-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : systems-chat-api-prod-repo
resource "aws_ecr_repository" "systems-chat-api-prod-repo" {
    name                 = "systems-chat-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
#################################################
# LRC
# Repository Name : lrc-app-api-dev-repo
resource "aws_ecr_repository" "lrc-app-api-dev-repo" {
    name                 = "lrc-app-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : lrc-app-api-prod-repo
resource "aws_ecr_repository" "lrc-app-api-prod-repo" {
    name                 = "lrc-app-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : lrc-app-web-dev-repo
resource "aws_ecr_repository" "lrc-app-web-dev-repo" {
    name                 = "lrc-app-web-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : lrc-app-web-prod-repo
resource "aws_ecr_repository" "lrc-app-web-prod-repo" {
    name                 = "lrc-app-web-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : lrc-mng-api-dev-repo
resource "aws_ecr_repository" "lrc-mng-api-dev-repo" {
    name                 = "lrc-mng-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : lrc-mng-api-prod-repo
resource "aws_ecr_repository" "lrc-mng-api-prod-repo" {
    name                 = "lrc-mng-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : lrc-mng-web-dev-repo
resource "aws_ecr_repository" "lrc-mng-web-dev-repo" {
    name                 = "lrc-mng-web-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : lrc-mng-web-prod-repo
resource "aws_ecr_repository" "lrc-mng-web-prod-repo" {
    name                 = "lrc-mng-web-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
##########################################################
# CPC
# Repository Name : cpc-app-api-dev-repo
resource "aws_ecr_repository" "cpc-app-api-dev-repo" {
    name                 = "cpc-app-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : cpc-app-api-prod-repo
resource "aws_ecr_repository" "cpc-app-api-prod-repo" {
    name                 = "cpc-app-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : cpc-app-web-dev-repo
resource "aws_ecr_repository" "cpc-app-web-dev-repo" {
    name                 = "cpc-app-web-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : cpc-app-web-prod-repo
resource "aws_ecr_repository" "cpc-app-web-prod-repo" {
    name                 = "cpc-app-web-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cpc-mng-api-dev-repo
resource "aws_ecr_repository" "cpc-mng-api-dev-repo" {
    name                 = "cpc-mng-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : cpc-mng-api-prod-repo
resource "aws_ecr_repository" "cpc-mng-api-prod-repo" {
    name                 = "cpc-mng-api-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cpc-mng-web-dev-repo
resource "aws_ecr_repository" "cpc-mng-web-dev-repo" {
    name                 = "cpc-mng-web-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

# Repository Name : cpc-mng-web-prod-repo
resource "aws_ecr_repository" "cpc-mng-web-prod-repo" {
    name                 = "cpc-mng-web-prod-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

#######################################################################
# 공지 내재화 프로젝트 ECR 레포지토리 생성
# Repository Name : cms-app-web-dev-repo 
resource "aws_ecr_repository" "cms-app-web-dev-repo" {
    name                 = "cms-app-web-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cms-app-api-dev-repo
resource "aws_ecr_repository" "cms-app-api-dev-repo" {
    name                 = "cms-app-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cms-gateway-api-dev-repo
resource "aws_ecr_repository" "cms-gateway-api-dev-repo" {
    name                 = "cms-gateway-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cms-mng-api-dev-repo
resource "aws_ecr_repository" "cms-mng-api-dev-repo" {
    name                 = "cms-mng-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : cms-batch-api-dev-repo
resource "aws_ecr_repository" "cms-batch-api-dev-repo" {
    name                 = "cms-batch-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : internal-gateway-api-dev-repo
resource "aws_ecr_repository" "internal-gateway-api-dev-repo" {
    name                 = "internal-gateway-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : external-gateway-api-dev-repo
resource "aws_ecr_repository" "external-gateway-api-dev-repo" {
    name                 = "external-gateway-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
# Repository Name : inner-gateway-api-dev-repo
resource "aws_ecr_repository" "inner-gateway-api-dev-repo" {
    name                 = "innert-gateway-api-dev-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}
