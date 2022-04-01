# output "lambda_role_name" {
#   value = aws_iam_role.lambda_role.name
# }

# output "lambda_role_arn" {
#   value = aws_iam_role.lambda_role.arn
# }

# output "aws_iam_policy_lambda_logging_arn" {
#   value = aws_iam_policy.lambda_logging.arn
# }

output "lambda_value" {
  value = data.aws_s3_object.mylambdacode_hash.body
}