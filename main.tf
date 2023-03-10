resource "awscc_pipes_pipe" "pipe" {
  name     = "pipe-customer-request"
  role_arn = aws_iam_role.pipe_iam_role.arn

  source = aws_sqs_queue.customer_request_sqs.arn

  source_parameters = {
    sqs = {
      sqs_queue_parameters = {
        batch_size = 10
      }
    }

    filter_criteria = {
      filters = [{ pattern = "{ \"body\": { \"customer_type\": [\"Platinum\"] }}" }]
    }
  }

  enrichment = module.enrich_customer_request_lambda.lambda_function_arn
  enrichment_parameters = {
    input_template = "{\"id\": \"<$.body.id>\",  \"customer_type\": \"<$.body.customer_type>\", \"query\": \"<$.body.query>\",\"severity\": \"<$.body.severity>\", \"created_date\" : \"<$.body.createdDate>\"}"
  }

  target = module.process_customer_request_lambda.lambda_function_arn
}

resource "aws_sqs_queue" "customer_request_sqs" {
  name = "customer-request"
}

module "enrich_customer_request_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "enrich-customer-request"
  source_path            = "${path.module}/lambda/enrich-customer-request"
  handler                = "index.handler"
  runtime                = "nodejs18.x"
  local_existing_package = "${path.module}/lambda/enrich-customer-request/index.zip"
  create_role            = false
  lambda_role            = aws_iam_role.enrich_customer_request_lambda_iam_role.arn
}

module "process_customer_request_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "process-customer-request"
  source_path            = "${path.module}/lambda/process-customer-request"
  handler                = "index.handler"
  runtime                = "nodejs18.x"
  local_existing_package = "${path.module}/lambda/process-customer-request/index.zip"
  create_role            = false
  lambda_role            = aws_iam_role.process_customer_request_lambda_iam_role.arn
}

