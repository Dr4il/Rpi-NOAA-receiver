resource "aws_s3_bucket" "images" {
  bucket = "drail-noaa-images"
  acl    = "private"
  tags = {
    Name        = "Images"
  }
}