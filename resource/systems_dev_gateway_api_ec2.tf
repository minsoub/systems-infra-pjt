# # Gateway API Server #1, #2

# variable "ingressRules" {
#     type = list(number)
#     default = [8080, 22]
# }

# // Gatewat API Server Security Group
# resource "aws_security_group" "systems_dev_gateway_sg" {
#     name = "systems_dev_gateway_sg"
#     description = "Security group for gateway instance"
#     vpc_id = aws_vpc.systems_dev_vpc.id

#     dynamic "ingress" {
#         iterator = port
#         for_each = var.ingressRules
#         content {
#             from_port = port.value
#             to_port = port.value
#             protocol = "TCP"
#             cidr_blocks = ["0.0.0.0/0"]
#             description = null
#             ipv6_cidr_blocks = null
#             prefix_list_ids = null
#             security_groups = null
#             self = null
#         }
#     }


#     # ingress {
#     #     from_port = 22
#     #     to_port = 22
#     #     protocol = "tcp"
#     #     cidr_blocks = ["0.0.0.0/0"]
#     # }

#     # ingress {
#     #     from_port = 8080
#     #     to_port = 8080
#     #     protocol = "tcp"
#     #     cidr_blocks = ["0.0.0.0/0"]
#     # }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     tags = {
#         Name ="Gateway Instance Security Group"
#     }
# }

# // EC2 Instance creation for Gateway API Server
# // 2vCPU, 8GiB
# resource "aws_instance" "systems_dev_gateway_instance1" {
#     ami = data.aws_ami.amazon_linux.id
#     availability_zone = aws_subnet.systems_dev_private_subnet1.availability_zone
#     instance_type = "t4g.large"
#     key_name = "systems_ec2_auth_key"
#     vpc_security_group_ids = [
#         aws_default_security_group.systems_dev_default_sg.id,
#         aws_security_group.systems_dev_gateway_sg.id
#     ]
#     root_block_device {
#         delete_on_termination = true
#         iops = 150
#         volume_size = 100
#         volume_type = "gp2"
#     }
#     subnet_id = aws_subnet.systems_dev_private_subnet1.id
#     associate_public_ip_address = true

#     tags = {
#         Name = "Gateway API Server Instance1"
#         Type = "Systems Gateway API"
#     }
# }

# resource "aws_instance" "systems_dev_gateway_instance2" {
#     ami = data.aws_ami.amazon_linux.id
#     availability_zone = aws_subnet.systems_dev_private_subnet2.availability_zone
#     instance_type = "t4g.large"
#     key_name = "systems_ec2_auth_key"
#     vpc_security_group_ids = [
#         aws_default_security_group.systems_dev_default_sg.id,
#         aws_security_group.systems_dev_gateway_sg.id
#     ]
#     root_block_device {
#         delete_on_termination = true
#         iops = 150
#         volume_size = 100
#         volume_type = "gp2"
#     }
#     subnet_id = aws_subnet.systems_dev_private_subnet2.id
#     associate_public_ip_address = true

#     tags = {
#         Name = "Gateway API Server Instance2"
#         Type = "Systems Gateway API"
#     }
# }



# // Output
# output "ec2instance-gateway-server1" {
#     value = aws_instance.systems_dev_gateway_instance1.private_ip
# }
# output "ec2instance-gateway-server2" {
#     value = aws_instance.systems_dev_gateway_instance2.private_ip
# }