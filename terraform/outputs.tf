output "bucket_name" {
  description = "Name of the S3 bucket containing taxi fleet data"
  value       = aws_s3_bucket.taxi_fleet.id
}

output "bucket_region" {
  description = "AWS region of the S3 bucket"
  value       = aws_s3_bucket.taxi_fleet.region
}

output "taxi_data_url" {
  description = "Public URL to taxi data JSON"
  value       = "https://${aws_s3_bucket.taxi_fleet.id}.s3.${var.aws_region}.amazonaws.com/taxis.json"
}