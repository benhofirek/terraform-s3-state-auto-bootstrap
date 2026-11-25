
terraform {
  required_version = ">= ${var.opentofu_version}"

  backend "s3" {
    bucket       = var.state_bucket_name
    key          = local.state_key
    region       = var.aws_region
    encrypt      = true
    use_lockfile = true
  }
}

module "state-bucket" {
  source = "../modules/state-bucket"

  state_bucket_name = var.state_bucket_name
  aws_region        = var.aws_region
}
