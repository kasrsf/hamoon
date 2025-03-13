terraform {
  backend "s3" {
    bucket         = "hamoon-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "hamoon-terraform-locks"
    encrypt        = true
  }
}