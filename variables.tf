variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}


variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  type = string
}

variable "error_html_filepath" {
  type = string
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number
}

variable "public_path" {
  description = "Path to public folder"
  type = string 
}

variable "terratowns_endpoint" {
  description = "Terratowns cloud endpoint"
  type = string 
}