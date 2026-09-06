# S3 bucket for autonomous taxi fleet data
resource "aws_s3_bucket" "taxi_fleet" {
  bucket = var.bucket_name

  tags = {
    Name        = "Autonomous Taxi Fleet Data"
    Environment = "demo"
    ManagedBy   = "terraform"
  }
}

# Enable public read access (for demo purposes)
resource "aws_s3_bucket_public_access_block" "taxi_fleet" {
  bucket = aws_s3_bucket.taxi_fleet.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "taxi_fleet" {
  bucket = aws_s3_bucket.taxi_fleet.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.taxi_fleet.arn}/*"
      }
    ]
  })
}

# Upload taxi data to S3
resource "aws_s3_object" "taxis_json" {
  bucket       = aws_s3_bucket.taxi_fleet.id
  key          = "taxis.json"
  source       = "${path.module}/../data/taxis.json"
  content_type = "application/json"
  source_hash  = filemd5("${path.module}/../data/taxis.json")

  tags = {
    Name = "Taxi Fleet Inventory"
  }
}