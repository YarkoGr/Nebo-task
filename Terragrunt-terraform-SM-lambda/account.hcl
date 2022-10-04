# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "main"
  aws_account_id = 057821068696
  aws_profile    = "partyuser"
}