# output "zookeeper_connect_string" {
#     value = aws_msk_cluster.systems-msk-cluster.zookeeper_connect_string
# }

# output "bootstrap_broker_tls" {
#     description = "TLS connection host:prt paris"
#     value       = aws_msk_cluster.systems-msk-cluster.bootstrap_brokers_tls
# }

// Output
output "systems-dev-logserver-alb-dns-name" {
    value = aws_alb.systems-dev-logserver-alb.dns_name
}

// Output
# output "gateway-alb_dns_name" {
#     value = aws_alb.systems-dev-gateway-alb.dns_name
# }