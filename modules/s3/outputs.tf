output "bucket_id" {
  description = "ID du bucket S3 créé"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "ARN du bucket S3"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_domain_name" {
  description = "Nom de domaine du bucket S3"
  value       = aws_s3_bucket.bucket.bucket_domain_name
} 