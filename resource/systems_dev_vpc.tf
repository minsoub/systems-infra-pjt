// VPC
resource "aws_vpc" "systems_eks_vpc" {
    cidr_block = "10.2.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
        "Name" = "BithumbSystems EKS VPC"
        "kubernates.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

// Default Route table
resource "aws_default_route_table" "systems_eks_vpc" {
    default_route_table_id = aws_vpc.systems_eks_vpc.default_route_table_id

    tags = {
        Name = "default"
    }
}

// Public Subnet1, Subnet2
resource "aws_subnet" "systems_dev_public_subnet1" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    cidr_block = "10.2.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        "Name" = "public-subnet-az1"
        "kubernates.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_subnet" "systems_dev_public_subnet2" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    cidr_block = "10.2.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "public-subnet-az2"
        "kubernates.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

// Private Subnet1, Subnet2
resource "aws_subnet" "systems_dev_private_subnet1" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    cidr_block = "10.2.10.0/24"
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "private-subnet-az1"
        "kubernates.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_subnet" "systems_dev_private_subnet2" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    cidr_block = "10.2.11.0/24"
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "private-subnet-az2"
        "kubernates.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

// Internet Gateway
resource "aws_internet_gateway" "systems_dev_igw" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    tags = {
        Name = "systems-dev-internet-gateway"
    }
}

// Route to Internet
resource "aws_route" "systems_dev_internet_access" {
    route_table_id = aws_vpc.systems_eks_vpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.systems_dev_igw.id
}

// EIP for NAT
resource "aws_eip" "systems_dev_nat_eip" {
    vpc = true
    depends_on = [aws_internet_gateway.systems_dev_igw]
}

// NAT gateway
resource "aws_nat_gateway" "systems_dev_nat" {
    allocation_id = aws_eip.systems_dev_nat_eip.id
    subnet_id = aws_subnet.systems_dev_public_subnet1.id
    depends_on = [aws_internet_gateway.systems_dev_igw]
}

// Private route table
resource "aws_route_table" "systems_dev_private_route_table" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    tags = {
        Name = "Private Route Table"
    }
}

resource "aws_route" "systems_dev_private_route" {
    route_table_id = aws_route_table.systems_dev_private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.systems_dev_nat.id
}

// associate subnets to route tables
// Main Route Table -> Public Subnet
resource "aws_route_table_association" "systems_dev_public_subnet1_assocation" {
    subnet_id = aws_subnet.systems_dev_public_subnet1.id
    route_table_id = aws_vpc.systems_eks_vpc.main_route_table_id
}

resource "aws_route_table_association" "systems_dev_public_subnet2_assocation" {
    subnet_id = aws_subnet.systems_dev_public_subnet2.id
    route_table_id = aws_vpc.systems_eks_vpc.main_route_table_id
}

// Private Route Table -> Private Subnet
resource "aws_route_table_association" "systems_dev_private_subnet1_association" {
    subnet_id = aws_subnet.systems_dev_private_subnet1.id
    route_table_id = aws_route_table.systems_dev_private_route_table.id
}

resource "aws_route_table_association" "systems_dev_private_subnet2_assocation" {
    subnet_id = aws_subnet.systems_dev_private_subnet2.id
    route_table_id = aws_route_table.systems_dev_private_route_table.id
}

// Default Security Group
resource "aws_default_security_group" "systems_dev_default_sg" {
    vpc_id = aws_vpc.systems_eks_vpc.id

    ingress {
        protocol = -1
        self     = true
        from_port = 0
        to_port   = 0
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "default"
    }
}

resource "aws_default_network_acl" "systems_dev_default_acl" {
    default_network_acl_id = aws_vpc.systems_eks_vpc.default_network_acl_id

    ingress {
        protocol = -1
        rule_no  = 100
        action   = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    egress {
        protocol = -1
        rule_no  = 100
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }

    tags = {
        Name = "default"
    }
}

// Network ACL form public subnets
resource "aws_network_acl" "systems_dev_public_acl" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    subnet_ids  = [
        aws_subnet.systems_dev_public_subnet1.id,
        aws_subnet.systems_dev_public_subnet2.id,
    ]

    tags = {
        Name = "public Network ACL"
    }
}

// Network ACL Rule
// 80,443,22, ephemeral port open (inbound/outbound) => 외부
// 추가 port : 8080, 9090, 3000, 27017, 6379   => 내부
resource "aws_network_acl_rule" "systems_dev_public_ingress80" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 100
    rule_action = "allow"
    egress = false
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
}

resource "aws_network_acl_rule" "systems_dev_public_egress80" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 100
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
}

resource "aws_network_acl_rule" "systems_dev_public_ingress443" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 110
    rule_action = "allow"
    egress = false
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443  
}

resource "aws_network_acl_rule" "systems_dev_public_egress443" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 110
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
}

resource "aws_network_acl_rule" "systems_dev_public_ingress22" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 120
    rule_action = "allow"
    egress = false
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "systems_dev_public_egress22" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 120
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = aws_vpc.systems_eks_vpc.cidr_block
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "systems_dev_public_ingress_ephemeral" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 140
    rule_action = "allow"
    egress = false
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "systems_dev_public_egress_ephemeral" {
    network_acl_id = aws_network_acl.systems_dev_public_acl.id
    rule_number = 140
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

// Network ACL for Private Subnets
resource "aws_network_acl" "systems_dev_private_acl" {
    vpc_id = aws_vpc.systems_eks_vpc.id
    subnet_ids = [
        aws_subnet.systems_dev_private_subnet1.id,
        aws_subnet.systems_dev_private_subnet2.id,
    ]

    tags = {
        Name = "Private Network ACL"
    }
}

// Private Network ACL Rule
resource "aws_network_acl_rule" "systems_dev_private_ingress_vpc" {
    network_acl_id = aws_network_acl.systems_dev_private_acl.id
    rule_number = 100
    rule_action = "allow"
    egress = false
    protocol = -1
    cidr_block = aws_vpc.systems_eks_vpc.cidr_block
    from_port = 0
    to_port = 0
}

resource "aws_network_acl_rule" "systems_dev_private_egress_vpc" {
    network_acl_id = aws_network_acl.systems_dev_private_acl.id
    rule_number = 100
    rule_action = "allow"
    egress = true
    protocol = -1
    cidr_block = aws_vpc.systems_eks_vpc.cidr_block
    from_port = 0
    to_port = 0
}

resource "aws_network_acl_rule" "systems_dev_private_ingress_nat" {
    network_acl_id = aws_network_acl.systems_dev_private_acl.id
    rule_number = 110
    rule_action = "allow"
    egress = false
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "systems_dev_private_egress80" {
    network_acl_id = aws_network_acl.systems_dev_private_acl.id
    rule_number = 120
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
}

resource "aws_network_acl_rule" "systems_dev_private_egress443" {
    network_acl_id = aws_network_acl.systems_dev_private_acl.id
    rule_number = 130
    rule_action = "allow"
    egress = true
    protocol = "tcp"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
}


