variable "region" {
  description = "The region in which resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "s3_dist_bucket" {
  description = "The name of the S3 bucket to store the website content"
  type        = string
  default     = "milan-s3-frontend-bucket"
}