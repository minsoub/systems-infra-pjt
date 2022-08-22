# resource "aws_vpc" "systems-dev-vpc" {
#     assign_generated_ipv6_cidr_block = false
#     cidr_block = "10.10.0.0/16"
#     enable_classiclink = false
#     enable_classiclink_dns_support = false
#     enable_dns_hostnames = true
#     enable_dns_support = true
#     instance_tenancy = "default"
#     ipv4_ipam_pool_id = null
#     ipv4_netmask_length = null
#     tags = {
#         "Name" = "systems-dev-vpc"
#     }
# }