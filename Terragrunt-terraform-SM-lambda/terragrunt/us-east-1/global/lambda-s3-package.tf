module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.0.1"

  function_name = "ypasko-lambda"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  create_package = false

  s3_existing_package = {
    bucket = one(module.s3_bucket_lambda[*].s3_bucket_id)
    key    = aws_s3_object.my_function.id
  }

  environment_variables = {
    YPASKO_USERNAME = local.ypasko_creds.username
    YPASKO_PASSWORD = local.ypasko_creds.password
  }

  tags = local.lambda_tags

  depends_on = [
    module.s3_bucket_lambda
  ]
}

