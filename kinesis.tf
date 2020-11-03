resource "aws_kinesis_firehose_delivery_stream" "input" {
  name        = "${local.prefix}-input"
  destination = "extended_s3"

  server_side_encryption {
    enabled = true
  }

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.storage.arn
    prefix     = "firehose-output/"

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.processor.arn}:$LATEST"
        }
      }
    }
  }
}
