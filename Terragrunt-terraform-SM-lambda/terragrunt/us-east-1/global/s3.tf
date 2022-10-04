module "s3_bucket_lambda" {
  count = length(var.bucket)

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket = var.bucket[count.index]
  acl    = "private"

  versioning = {
    enabled = false
  }

  # lifecycle_rule = [
  #   {
  #     id      = "transferFile-30days"
  #     enabled = true

  #     transition = [
  #       {
  #         days          = var.transition_days
  #         storage_class = "ONEZONE_IA"
  #       },
  #     ]
  #   },
  # ]

}

resource "aws_s3_object" "my_function" {
  bucket = one(module.s3_bucket_lambda[*].s3_bucket_id)
  key    = "${filemd5(local.my_function_code)}.zip"
  source = local.my_function_code
}