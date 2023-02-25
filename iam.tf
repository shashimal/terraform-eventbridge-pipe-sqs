resource "aws_iam_role" "pipe_iam_role" {
  name               = "pipe-sqs-role"
  assume_role_policy = data.aws_iam_policy_document.pipe_assume_policy_document.json
}

resource "aws_iam_role_policy" "pipe_iam_role_permission_policy" {
  role   = aws_iam_role.pipe_iam_role.id
  policy = data.aws_iam_policy_document.pipe_iam_policy_document.json
}

resource "aws_iam_role" "enrich_customer_request_lambda_iam_role" {
  name               = "enrich-customer-request-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy_document.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_iam_role" "process_customer_request_lambda_iam_role" {
  name               = "process-customer-request-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_policy_document.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}
