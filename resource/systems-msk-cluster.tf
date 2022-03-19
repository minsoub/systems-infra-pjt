resource "aws_kms_key" "systems-msk-kms-key" {
    description = "MSK KMS Key"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "msk-broker-logs-bucket"
}
resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
}

# MSK configuration
resource "aws_msk_configuration" "systems-msk-configuration" {
    kafka_versions    = [var.msk-kafka-version]
    name              = "systems-msk-configuration"
    server_properties = <<PROPERTIES
auto.create.topics.enable = true
delete.topic.enable = true
PROPERTIES

    lifecycle {
        create_before_destroy = true
    }
}
# MSK cluster
resource "aws_msk_cluster" "systems-msk-cluster" {

    cluster_name            = var.msk-cluster-name 
    kafka_version           = var.msk-kafka-version 
    number_of_broker_nodes  = 3
    enhanced_monitoring     = "PER_BROKER"

    broker_node_group_info {
        instance_type = var.msk-instance-type
        ebs_volume_size = var.msk-ebs_volume_size
        client_subnets = [
            aws_subnet.systems_dev_private_subnet1.id, 
            aws_subnet.systems_dev_private_subnet2.id, 
            aws_subnet.systems_dev_private_subnet2.id
        ]
        security_groups = [aws_security_group.systems-msk-sg.id]
    }

    configuration_info {
        arn      = aws_msk_configuration.systems-msk-configuration.arn
        revision = aws_msk_configuration.systems-msk-configuration.latest_revision
    }
    encryption_info {
        encryption_at_rest_kms_key_arn = aws_kms_key.systems-msk-kms-key.arn
        /* encryption_in_transit {
            client_broker = 
            in_cluster = 
        } */
    }

    open_monitoring {
        prometheus {
            jmx_exporter {
                enabled_in_broker = true
            }
            node_exporter {
                enabled_in_broker = true
            }
        }
    }

    logging_info {
        broker_logs {
            s3 {
                enabled = true
                bucket = aws_s3_bucket.bucket.id
                prefix = "logs/msk-"
            }
        }
    }

    tags = {
        Name = "Systems MSK"
    }
}