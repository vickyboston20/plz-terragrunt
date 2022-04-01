data "archive_file" "default" {
  for_each = fileset("${path.module}/python_files/RPT/deployment/Working/Lambda/","*.py")
  type        = "zip"
  source_file  = "${path.module}/python_files/RPT/deployment/Working/Lambda/${each.value}"
  output_file_mode = "0666"
  output_path = "${path.module}/myzip/${each.value}.zip"
}

resource "aws_s3_object" "lambda_scripts_upload_to_s3" {
  for_each = fileset("${path.module}/myzip/","*.zip")
  bucket = "lambda-test-eo1536"
  key = "lambda/${each.value}"
  source = "${path.module}/myzip/${each.value}"
  etag = filemd5("${path.module}/myzip/${each.value}")
  depends_on = [
    data.archive_file.default
  ]
}

