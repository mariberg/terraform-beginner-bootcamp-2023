terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  public_path = var.public_path
#  content_version = var.content_version
#}

resource "terratowns_home" "home" {
  name = "Uno Card Game in 2023"
  description = <<DESCRIPTION
  Uno is a brilliantly simple card game that never fails to deliver endless fun. 
  With just a deck of colorful cards and a few straightforward rules, players embark
  on a thrilling journey of strategy and chance.
  DESCRIPTION 
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers grotto"
  content_version = 1
}