variable "environment" {
  type        = string
  description = "Environment represented by the local inventory."
  default     = "local"
}

variable "image_tag" {
  type        = string
  description = "Versioned local-registry image reference."
  default     = "localhost:5000/cloudnotes:1.0.0"
}
