terraform {
  backend "s3" {
    bucket = "shahirmulticloud"
    key    = "network/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true
  }
}