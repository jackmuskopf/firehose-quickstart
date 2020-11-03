resource "aws_s3_bucket" "storage" {
  bucket = "${local.prefix}"
  acl    = "private"
}
