variable "user_uuid" {
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

variable "assets_path" {
  description = "Path to assets folder"
  type = string 
}