# ACM CERTIFICATE - provisions SSL/TLS certificate for HTTPS
resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name                  # primary domain (e.g. example.com)
  subject_alternative_names = var.subject_alternative_names    # additional domains (e.g. www.example.com)
  validation_method         = "DNS"                            # DNS validation via Route53

  # Ensures zero downtime during certificate replacement
  lifecycle {
    create_before_destroy = true
  }
}

# LOOKUP EXISTING ROUTE53 HOSTED ZONE
data "aws_route53_zone" "this" {
  name         = var.domain_name   # domain must already exist in Route53
  private_zone = false             # public hosted zone
}

# CREATE DNS RECORDS FOR CERTIFICATE VALIDATION
# ACM provides validation records which must be added to Route53
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name   # DNS record name
      type  = dvo.resource_record_type   # usually CNAME
      value = dvo.resource_record_value  # validation value from ACM
    }
  }

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60  # low TTL for faster validation
}

# CERTIFICATE VALIDATION - tells AWS to verify the DNS records
resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn

  # Collect all validation record FQDNs dynamically
  validation_record_fqdns = [
    for r in aws_route53_record.validation : r.fqdn
  ]
}