output "regionOfS3_creation" {
  value = aws_s3_bucket.demo_bucket.bucket_region
}

output "BucketName" {
  value = aws_s3_bucket.demo_bucket.bucket
}

output "Bucket_id"{
    value = aws_s3_bucket.demo_bucket.id
}

output "acl"{
    value = aws_s3_bucket.demo_bucket.tags_all
}

output "arn"{
    value = aws_s3_bucket.demo_bucket.arn
}

output "Result"{
    value = random_id.rand_id.dec
}