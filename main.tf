provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "milan-s3-tf-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "milan-dynamodb-tf-lock"
  }
}

locals {
  bucket_name = "${var.s3_dist_bucket}-${terraform.workspace}"
}

resource "aws_s3_bucket" "frontend_dist" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "frontend_dist_versioning" {
  bucket = aws_s3_bucket.frontend_dist.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "frontend_dist_lock" {
  depends_on          = [aws_s3_bucket.frontend_dist]
  bucket              = aws_s3_bucket.frontend_dist.id
  object_lock_enabled = "Enabled"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "frontend_dist_encryption" {
  bucket = aws_s3_bucket.frontend_dist.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

