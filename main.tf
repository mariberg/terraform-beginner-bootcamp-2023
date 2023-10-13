terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

 #backend "remote" {
 #   hostname = "app.terraform.io"
 #   organization = "Marika"
#
 #   workspaces {
  #    name = "terra-house-1"
 #   }
  #}

  cloud {
    organization = "Marika"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "home_licorice_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.licorice.public_path
  content_version = var.licorice.content_version
}

resource "terratowns_home" "home_licorice" {
  name = "Uno Card Game in 2023"
  description = <<DESCRIPTION
  Uno is a brilliantly simple card game that never fails to deliver endless fun. 
  With just a deck of colorful cards and a
  DESCRIPTION 
  domain_name = module.home_licorice_hosting.domain_name
  #domain_name = "3fee3gg.cloudfront.net"
  town = "missingo"
  content_version = var.home_licorice_hosting.content_version
}

module "home_uno_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.uno.public_path
  content_version = var.uno.content_version
}

resource "terratowns_home" "home_uno" {
  name = "Uno"
  description = <<DESCRIPTION
  Examples of best cakes
  DESCRIPTION 
  domain_name = module.home_uno_hosting.domain_name
  #domain_name = "3fee3gg.cloudfront.net"
  town = "missingo"
  content_version = var.home_uno_hosting.content_version
}