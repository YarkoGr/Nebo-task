resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "ypasko_sm" {
#   count = var.ypasko_secrets == true ? 1 : 0

  name                    = var.ypasko_secrets
  description             = "ypasko Lambda variables [tf]"
  recovery_window_in_days = 7
  tags                    = local.lambda_tags

}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.ypasko_sm.id
  secret_string = <<EOF
    {
        "username": "${var.ypasko_admin_passwd}",
        "password": "${random_password.password.result}"
    }
EOF
}

data "aws_secretsmanager_secret" "ypasko_sm" {
  arn = aws_secretsmanager_secret.ypasko_sm.arn
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.ypasko_sm.arn
}