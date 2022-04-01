generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
        region = "${get_env("TF_VAR_region", "us-east-2")}"
        # profile = "default"
        alias = "primary"
    }
    EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "prft-tf-state-${get_env("TF_VAR_account_number", "251721600074")}"
    key            = "terraform/${get_env("TF_VAR_region", "us-east-2")}/${path_relative_to_include()}/terraform.tfstate"
    region         = "${get_env("TF_VAR_region", "us-east-2")}"
    encrypt        = true
    dynamodb_table = "prft-tf-lock-${get_env("TF_VAR_account_number", "251721600074")}"
  }
}