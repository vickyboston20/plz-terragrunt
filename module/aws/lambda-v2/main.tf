# Creating IAM role so that Lambda service to assume the role and access other AWS services. 

resource "aws_iam_role" "lambda_role" {
 name   = "iam_role_lambda_function"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "lambda_logging" {

  name         = "iam_policy_lambda_logging_function"
  path         = "/"
  description  = "IAM policy for logging from a lambda"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.lambda_logging.arn
}

# Generates an archive from content, a file, or a directory of files.

# resource "null_resource" "python_files" {
#   provisioner "local-exec" {
#     command = <<EOT
#         git clone https://github.com/vickyboston20/plz-lambda.git python_files
#         EOT
#   }
#   provisioner "local-exec" {
#     when = destroy
#     command = <<EOT
#         rm -rf python_files
#         EOT
#   }
# }

# data "archive_file" "default" {
#   type        = "zip"
#   source_dir  = "${path.module}/python_files/RPT/deployment/Working/Lambda"
#   output_path = "${path.module}/myzip/python.zip"
#   depends_on = [
#     null_resource.python_files
#   ]
# }

# resource "aws_s3_object" "lambda_scripts_upload_to_s3" {
#   for_each = fileset("${path.module}/python_files/RPT/deployment/Working/Lambda","*.py")
#   bucket = "prft-vignesh-cigna-tfstate"
#   key = "lambda/${each.value}"
#   source = "${path.module}/python_files/RPT/deployment/Working/Lambda/${each.value}"
#   etag = filemd5("${path.module}/python_files/RPT/deployment/Working/Lambda/${each.value}")
#   depends_on = [
#     null_resource.python_files
#   ]
# }


# Create a lambda function
# data "aws_s3_object" "mylambdacode_hash" {
#   bucket = "lambda-test-eo1536"
#   key    = "lambda/index.zip.base64sha256"
# }
data "aws_s3_object" "mylambdacode" {
  bucket = "lambda-test-eo1536"
  key    = "lambda/index.zip"
}
# In terraform ${path.module} is the current directory.



resource "aws_lambda_function" "lambdafunc" {
  function_name                  = "My_Lambda_function"
  role                           = aws_iam_role.lambda_role.arn
  handler                        = "index.lambda_handler"
  publish                        = true
  runtime                        = "python3.8"
  s3_bucket                      = data.aws_s3_object.mylambdacode.bucket
  s3_key                         = data.aws_s3_object.mylambdacode.key
  s3_object_version              = data.aws_s3_object.mylambdacode.version_id
  # source_code_hash               = data.aws_s3_object.mylambdacode_hash.body
  depends_on                     = [aws_iam_role_policy_attachment.policy_attach]
  lifecycle {
    ignore_changes = [
      source_code_hash,
      last_modified,
      qualified_arn,
      version
    ]
  }
}
