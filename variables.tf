variable "region" {
  description = "The region in which resources will be created"
  default     = "us-east-1"
}

variable "s3_dist_bucket" {
  description = "The name of the S3 bucket to store the website content"
  default     = "milan-s3-frontend-bucket"
}
