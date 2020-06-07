resource "aws_s3_bucket" "images" {
  bucket = var.bucket
  acl    = "private"
  tags = {
    Name        = "Images"
  }
}