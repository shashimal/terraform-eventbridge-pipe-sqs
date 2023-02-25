output "customer_request_sqs_endpoint" {
  value = aws_sqs_queue.sqs.url
}
