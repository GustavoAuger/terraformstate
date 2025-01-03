provider "aws" {
  region  = "us-east-1"
  profile = "gustavodev"  # profile configurado
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-bucket-gustdev"
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "expire_at"
    enabled        = false
  }
}
