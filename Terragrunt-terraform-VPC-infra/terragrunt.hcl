# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Locals for main terragrunt configuration
locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("regional.hcl"))

  # Get the current account id
  aws_account = get_aws_account_id()

  # Extract the variables we need for easy access
  account_name    = local.account_vars.locals.account_name
  account_id      = local.account_vars.locals.aws_account_id
  aws_region      = local.region_vars.locals.aws_region
  aws_dr_region   = local.region_vars.locals.aws_dr_region

  # Set the state variables
  tfstate_region = "us-east-1"
  tfstate_bucket = "terragrunt-terraform-us-east-1"
  tfstate_table  = "terragrunt-terraform-us-east-1"
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.aws_account}"]

  # # Make it faster by skipping something
  # skip_get_ec2_platforms      = true
  # skip_metadata_api_check     = true
  # skip_region_validation      = true
  # skip_credentials_validation = true
}

provider "aws" {
  region = "${local.aws_dr_region}"
  alias  = "dr"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.aws_account}"]

  # Make it faster by skipping something
  # skip_get_ec2_platforms      = true
  # skip_metadata_api_check     = true
  # skip_region_validation      = true
  # skip_credentials_validation = true
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend      = "s3"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))

  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }

  config = {
    encrypt        = true
    region         = local.tfstate_region
    key            = format("%s/terraform-3f.tfstate", path_relative_to_include())
    bucket         = local.tfstate_bucket
    dynamodb_table = local.tfstate_table

    skip_metadata_api_check     = true
    skip_credentials_validation = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  # local.environment_vars.locals,
)