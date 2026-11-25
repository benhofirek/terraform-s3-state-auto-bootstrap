
terraform {
  required_version = ">= ${var.opentofu_version}"

  backend "local" {
    path = "./terraform.tfstate"
  }
}

module "state-bucket" {
  source = "../modules/state-bucket"

  state_bucket_name = var.state_bucket_name
  aws_region        = var.aws_region
}
