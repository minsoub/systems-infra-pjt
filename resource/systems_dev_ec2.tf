# Bastion HOST Server

// Bastion Host Security Group
resource "aws_security_group" "systems_dev_bastion_sg" {
    name = "bastion_instance_sg"
    description = "Security group for bastion instance"
    vpc_id = aws_vpc.systems_dev_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name ="Bastion Host Security Group"
    }
}

// EC2 Instacne creation for bastion host
// 2vCPU, 8GiB
resource "aws_instance" "systems_dev_bastion_instance" {
    ami = data.aws_ami.amazon_linux.id
    availability_zone = aws_subnet.systems_dev_public_subnet1.availability_zone
    instance_type = "t4g.large"
    key_name = "systems_ec2_auth_key"
    vpc_security_group_ids = [
        aws_default_security_group.systems_dev_default_sg.id,
        aws_security_group.systems_dev_bastion_sg.id
    ]
    root_block_device {
        delete_on_termination = true
        iops = 150
        volume_size = 100
        volume_type = "gp2"
    }
    subnet_id = aws_subnet.systems_dev_public_subnet1.id
    associate_public_ip_address = true

    tags = {
        Name = "Bastion Host Instance"
    }
}
resource "aws_eip" "systems_dev_bastion_instance_eip" {
    vpc = true
    instance = aws_instance.systems_dev_bastion_instance.id
    depends_on = [aws_internet_gateway.systems_dev_igw]
}

// Output
output "ec2instance" {
    value = aws_instance.systems_dev_bastion_instance.public_ip
}