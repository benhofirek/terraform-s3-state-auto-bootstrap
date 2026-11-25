variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  nullable    = false

  validation {
    condition     = var.state_bucket_name != ""
    error_message = "The 'state_bucket_name' variable must be set."
  }

  validation {
    condition     = length(var.state_bucket_name) <= 63
    error_message = "The state bucket name maximum length is 63"
  }
}

variable "aws_region" {
  description = "Region of the S3 state bucket"
  type        = string
  nullable    = false

  validation {
    condition     = var.aws_region != ""
    error_message = "The 'aws_region' variable must be set."
  }
}

variable "state_bucket_key_prefix" {
  description = "Name of the S3 bucket key prefix for Terraform state"
  type        = string
  default     = "infrastructure"
}

variable "opentofu_version" {
  description = "OpenTofu version to use"
  type        = number
  default     = 1.13
}
