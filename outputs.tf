output "bucket_name" {
    description = "Bucket name for our static website hosting"
    value = module.home_licorice_hosting.bucket_name
}

output "S3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.home_licorice_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront distribution domain name"
  value = module.home_licorice_hosting.domain_name
}