# Monitoring Systems & Log Collector
variable "ingressRulesLogServer" {
    type = list(number)
    default = [8080, 22, 9100, 3000, 9200, 5601, 5044]
}

// Gatewat API Server Security Group
resource "aws_security_group" "systems_dev_logserver_sg" {
    name = "systems_dev_logserver_sg"
    description = "Security group for Log Server instance"
    vpc_id = aws_vpc.systems_eks_vpc.id

    dynamic "ingress" {
        iterator = port
        for_each = var.ingressRulesLogServer
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
            description = null
            ipv6_cidr_blocks = null
            prefix_list_ids = null
            security_groups = null
            self = null
        }
    }


    # ingress {
    #     from_port = 22
    #     to_port = 22
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    # ingress {
    #     from_port = 8080
    #     to_port = 8080
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name ="Log Server Instance Security Group"
    }
}

// EC2 Instacne creation for Log Server
// 2vCPU, 8GiB
resource "aws_instance" "systems_dev_logserver_instance" {
    ami = data.aws_ami.amazon_linux.id
    availability_zone = aws_subnet.systems_dev_private_subnet2.availability_zone
    instance_type = "c5.2xlarge"
    key_name = "systems_ec2_auth_key"
    vpc_security_group_ids = [
        aws_default_security_group.systems_dev_default_sg.id,
        aws_security_group.systems_dev_logserver_sg.id
    ]
    root_block_device {
        delete_on_termination = true
        iops = 150
        volume_size = 100
        #volume_type = "gp2"
    }
    subnet_id = aws_subnet.systems_dev_private_subnet2.id
    associate_public_ip_address = true

    tags = {
        Name = "Log Server Instance"
    }
}

// Output
output "ec2instance-logserver" {
    value = aws_instance.systems_dev_logserver_instance.private_ip
}
