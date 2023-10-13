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
  name = "Licorice - sweet or salty treat"
  description = <<DESCRIPTION
  Explore a world of licorice delights, from sweet classics to the bold and 
  salty adventures of Nordic licorice. Dare to try the intriguing flavors of salty 
  licorice and unlock a whole new dimension of confectionery enjoyment!
  DESCRIPTION 
  domain_name = module.home_licorice_hosting.domain_name
  #domain_name = "3fee3gg.cloudfront.net"
  town = "cooker-cove"
  content_version = var.licorice.content_version
}

#module "home_uno_hosting" {
#  source = "./modules/terrahome_aws"
#  user_uuid = var.teacherseat_user_uuid
#  public_path = var.uno.public_path
#  content_version = var.uno.content_version
#}

#resource "terratowns_home" "home_uno" {
#  name = "Uno"
#  description = <<DESCRIPTION
#  Best card game
#  DESCRIPTION 
#  domain_name = module.home_uno_hosting.domain_name
#  #domain_name = "3fee3gg.cloudfront.net"
#  town = "missingo"
#  content_version = var.uno.content_version
#}