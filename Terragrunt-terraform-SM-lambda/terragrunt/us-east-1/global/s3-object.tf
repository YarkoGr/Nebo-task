

# module "s3_bucket_object_lambda" {
#   source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
#   version = "3.4.0"

#   bucket = one(module.s3_bucket_lambda[*].s3_bucket_id)
#   key = "${filemd5(local.my_function_code)}.zip"

#   depends_on = [
#     module.s3_bucket_lambda
#   ]
# }

