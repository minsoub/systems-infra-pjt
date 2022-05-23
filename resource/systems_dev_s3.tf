# s3 definition
resource "aws_s3_bucket" "s3-alb" {
    bucket = "gateway-alb-log"
    //policy = data.aws_iam_policy_document.allow_access_policy.json
}

resource "aws_s3_bucket_policy" "s3_alb_log_policy" {
    depends_on = [aws_s3_bucket.s3-alb]

    bucket = aws_s3_bucket.s3-alb.id
    policy = data.aws_iam_policy_document.allow_access_policy.json
}
resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle_rule" {
    bucket = aws_s3_bucket.s3-alb.id
    rule {
        id = "log_lifecycle"
        status = "Enabled"
        prefix = ""

        transition {
            days = 30
            storage_class = "GLACIER"
        }
        expiration {
            days = 90
        }
    }
    lifecycle {
        prevent_destroy = true
    }
}

data "aws_iam_policy_document" "allow_access_policy" {
    statement {
        principals {
          type    = "AWS"
          identifiers = ["${var.my_account_id}"]
        }

        actions = [
         "s3:PutObject",
        ]
        resources = [
          aws_s3_bucket.s3-alb.arn,
          "${aws_s3_bucket.s3-alb.arn}/*",
        ]
    }
}