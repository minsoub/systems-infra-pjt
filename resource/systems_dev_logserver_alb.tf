
# ALB Configuration
resource "aws_alb" "systems-dev-logserver-alb" {
    idle_timeout = 60
    internal = false
    name = "systems-dev-logserver-alb"
    security_groups = [aws_security_group.systems-dev-logserver-alb-sg.id]
    subnets = [
        aws_subnet.systems_dev_private_subnet2.id
    ]

    access_logs {
        bucket = aws_s3_bucket.alb.id
        prefix = "logserver-alb"
        enabled = true
    }

    tags = {
        Name = "systems-dev-logserver-alb"
        Service = "systems-dev-logserver"
    }
}

# ALB TargetGroup => logserver
resource "aws_alb_target_group" "prometheus-server" {
    name = "prometheus-server-target-group"
    port = 9100
    protocol = "HTTP"
    vpc_id = aws_vpc.systems_dev_vpc.id

    health_check {
        interval = 30
        path = "/"
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
    tags = {
        Name = "Prometheus Server Target Group"
    }
}
resource "aws_alb_target_group" "grafana-server" {
    name = "grafana-server-target-group"
    port = 3000
    protocol = "HTTP"
    vpc_id = aws_vpc.systems_dev_vpc.id

    health_check {
        interval = 30
        path = "/"
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
    tags = {
        Name = "Grafana Server Target Group"
    }
}

resource "aws_alb_target_group" "kibana-server" {
    name = "kibana-server-target-group"
    port = 5601
    protocol = "HTTP"
    vpc_id = aws_vpc.systems_dev_vpc.id

    health_check {
        interval = 30
        path = "/"
        healthy_threshold = 3
        unhealthy_threshold = 3
    }
    tags = {
        Name = "Kibana Server Target Group"
    }
}

// target group attachement
// 같은 서버의 여러개를 등록할 때 target_id에 배열 형식으로 정의
// Route-Robin 방식으로 연결된다.
// Prometheus
resource "aws_alb_target_group_attachment" "prometheus-server" {
    target_group_arn = aws_alb_target_group.prometheus-server.arn
    target_id = aws_instance.systems_dev_logserver_instance.id
    port = 9100
}
// Grafana
resource "aws_alb_target_group_attachment" "grafana-server" {
    target_group_arn = aws_alb_target_group.grafana-server.arn
    target_id = aws_instance.systems_dev_logserver_instance.id
    port = 3000
}
// Kibana
resource "aws_alb_target_group_attachment" "kibana-server" {
    target_group_arn = aws_alb_target_group.kibana-server.arn
    target_id = aws_instance.systems_dev_logserver_instance.id
    port = 5601
}

// ALB Listener
resource "aws_alb_listener" "prometheus-http" {
    load_balancer_arn = aws_alb.systems-dev-logserver-alb.arn
    port              = "9100"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.prometheus-server.arn
        type             = "forward"
    }
}
resource "aws_alb_listener" "grafana-http" {
    load_balancer_arn = aws_alb.systems-dev-logserver-alb.arn
    port              = "3000"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.grafana-server.arn
        type             = "forward"
    }
}
resource "aws_alb_listener" "kibana-http" {
    load_balancer_arn = aws_alb.systems-dev-logserver-alb.arn
    port              = "5601"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.kibana-server.arn
        type             = "forward"
    }
}


// Output
output "alb_dns_name" {
    value = aws_alb.systems-dev-logserver-alb.dns_name
}