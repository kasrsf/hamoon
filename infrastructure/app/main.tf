terraform {
  backend "s3" {
    bucket       = "hamoon-terraform-state"
    key          = "app/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
    profile      = "kastagh"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile_name
}

resource "aws_s3_bucket" "data_lake" {
  bucket = "hamoon-data-lake"

  tags = {
    Name = "DataLakeBucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket_ownership_controls.data_lake
  ]
}


resource "aws_s3_bucket_versioning" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_object" "raw_placeholder" {
  bucket       = aws_s3_bucket.data_lake.id
  key          = "raw/"
  content      = ""
  content_type = "application/x-directory"
}
