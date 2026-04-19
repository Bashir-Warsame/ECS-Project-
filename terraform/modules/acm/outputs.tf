output "certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "validation_id" {
  value = aws_acm_certificate_validation.this.id
}