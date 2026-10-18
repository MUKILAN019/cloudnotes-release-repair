resource "terraform_data" "release" {
  input = {
    service     = "cloudnotes"
    environment = var.environment_name
    image       = var.image_tag
  }
}
