terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  public_path = var.public_path
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = "Uno Card Game in 2023"
  description = <<DESCRIPTION
  Uno is a brilliantly simple card game that never fails to deliver endless fun. 
  With just a deck of colorful cards and a few straightforward rules, players embark
  on a thrilling journey of strategy and chance.
  DESCRIPTION 
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fee3gg.cloudfront.net"
  town = "missingo"
  content_version = 1
}