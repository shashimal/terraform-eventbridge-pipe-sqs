data "aws_iam_policy_document" "pipe_assume_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["pipes.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "pipe_iam_policy_document" {
  statement {
    sid    = "AllowPipeToAccessSQS"
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [aws_sqs_queue.sqs.arn]
  }

  statement {
    sid = "InvokeEnrichmentLambdaFunction"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = ["*"]
  }

}

data "aws_iam_policy_document" "lambda_assume_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "enrichment_customer_request_lambda_file" {
  type        = "zip"
  source_file = "${path.module}/lambda/enrich-customer-request/index.mjs"
  output_path = "${path.module}/lambda/enrich-customer-request/index.zip"
}

data "archive_file" "process_customer_request_lambda_file" {
  type        = "zip"
  source_file = "${path.module}/lambda/process-customer-request/index.mjs"
  output_path = "${path.module}/lambda/process-customer-request/index.zip"
}
