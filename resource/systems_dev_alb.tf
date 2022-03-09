# Target variable definition
# variable "targets" {
#   default = [
#     {
#       name = "user1"
#       port = 1010
#       path = "/user"
#     },
#     {
#       name = "user2"
#       port = 2020
#       path = "/v2/user"
#     }
#   ]
# }

# ALB Configuration
resource "aws_alb" "systems-dev-gateway-alb" {
    idle_timeout = 60
    internal = false
    name = "systems-dev-gateway-alb"
    security_groups = [aws_security_group.systems-dev-gateway-alb-sg.id]
    subnets = [
        "${aws_subnet.systems_dev_private_subnet1.id}", 
        "${aws_subnet.systems_dev_private_subnet2.id}"
    ]

    access_logs {
        bucket = aws_s3_bucket.alb.id
        prefix = "gateway-alb"
        enabled = true
    }

    tags = {
        Name = "systems-dev-gateway-alb"
        Service = "systems-dev-gateway"
    }
}

# ALB TargetGroup #1, #2 => gateway api #1, #2
resource "aws_alb_target_group" "gateway-api-server" {
    name = "gateway-api-server1-target-group"
    port = 8080
    protocol = "HTTP"
    vpc_id = aws_vpc.systems_dev_vpc.id

    health_check {
        interval = 30
        path = "/"
        healthy_threshold = 3
        unhealthy_threshold = 3
    }

    tags = {
        Name = "Gateway API Server Target Group"
    }
}
# resource "aws_alb_target_group" "gateway-api-server2" {
#     name = "gateway-api-server2-target-group"
#     port = 8080
#     protocol = "HTTP"
#     vpc_id = "${aws_vpc.systems_dev_vpc.id}"

#     health_check {
#         interval = 30
#         path = "/"
#         healthy_threshold = 3
#         unhealthy_threadhold = 3
#     }
#     tags {
#         Name = "Gateway API Server #2 Target Group"
#     }
# }

// target group attachement
// 같은 서버의 여러개를 등록할 때 target_id에 배열 형식으로 정의
// Route-Robin 방식으로 연결된다.
# data "aws_instances" "gateway_instances" {
#     instance_tags = {
#         Type = "Systems Gateway API"
#     }
# }
# resource "aws_alb_target_group_attachment" "gateway-api-server" {
#     for_each = toset(data.aws_instances.gateway_instances.ids)

#     target_group_arn = aws_alb_target_group.gateway-api-server.arn
#     target_id = each.value
#     port = 8080
# }

# 한개씩 연결할 때
resource "aws_alb_target_group_attachment" "gateway-api-server1" {
    target_group_arn = aws_alb_target_group.gateway-api-server.arn
    target_id = aws_instance.systems_dev_gateway_instance1.id
    port = 8080
}

resource "aws_alb_target_group_attachment" "gateway-api-server2" {
    target_group_arn = aws_alb_target_group.gateway-api-server.arn
    target_id = aws_instance.systems_dev_gateway_instance2.id
    port = 8080
}

// ALB Listener define
# AWS ACM Certificate  - 도메인에 따른 인증서 확인필요
# data "aws_acm_certificate" "bithumbsystems_dot_com" {
#     domain = "*.bithumbsystems.com."
#     statuses = ["ISSUED"]
# }

# resource "aws_alb_listener" "https" {
#     load_balancer_arn = "${aws_alb.systems-dev-gateway-alb.arn}"
#     port              = "443"
#     protocol          = "HTTPS"
#     ssl_policy        = "ELBSecurityPolicy-2016-08"
#     certificate_arn   = "${data.aws_acm_certificate.bithumbsystems_dot_com.arn}"

#     default_action {
#         target_group_arn = "${aws_alb_target_group.gateway-api-server.arn}"
#         type             = "forward"
#     }
# }

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_alb.systems-dev-gateway-alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.gateway-api-server.arn
        type             = "forward"
    }
}

// ALB Listener Rule 설정 
// 조건에 따른 request가 왔을 때 action을 정의
# resource "aws_alb_listener_rule" "static" {
#     listener_arn = "${aws_alb_listener.https.arn}"
#     priority     = 100

#     action {
#         type             = "forward"
#         target_group_arn = "${aws_alb_target_group.staic.arn}"
#     }
#     condition {
#         field = "path-pattern"
#         values = ["/static/*"]
#     }
# }

// Route53 DNS 통하여 custom domain을 설정
// 해당 도메인을 실제로 가지고 있어야 한다.
# resource "aws_route53_zone" "bitumbsystems" {
#     name = "bithumbsystems.com."
# }

# resource "aws_route53_record" "gateway_A" {
#     zone_id = "${data.awsa_route53_zone.bithumbsystems.zone_id}"
#     name = "bithumbsystems.com"
#     type = "A"

#     alias {
#         name = "${aws_alb.systems-dev-gateway-alb.dns_name}"
#         zone_id = "${aws_alb.systems-dev-gateway-alb.zone_id}"
#     }
# }

// Output
output "gateway-alb_dns_name" {
    value = aws_alb.systems-dev-gateway-alb.dns_name
}