terraform {
  backend "s3" {
    bucket = "drail-noaa-project"
    key    = "drail/noaa/bucket"
    region = "eu-west-1"
  }
}
