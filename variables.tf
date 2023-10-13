variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}

variable "terratowns_endpoint" {
  description = "Terratowns cloud endpoint"
  type = string 
}

variable "licorice" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "uno" {
  type = object({
    public_path = string
    content_version = number
  })
}