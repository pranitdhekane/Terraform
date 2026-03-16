terraform {
  backend "s3" {
    bucket = "pranit-terraform-bucket-demo"
    key = "pranit/terraform.state"
    region = "ap-south-1"
  }
}