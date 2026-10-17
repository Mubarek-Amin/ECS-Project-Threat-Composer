resource "aws_acm_certificate" "tc-acm" {
  domain_name = "amin-mubarek.com"
  validation_method = "DNS"
}