variable "aws_region" {
  type        = string
  description = "AWS region for S3 bucket"
  default     = "eu-central-1"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for taxi fleet data"
  default     = "taxi-fleet-berlin-demo"
}