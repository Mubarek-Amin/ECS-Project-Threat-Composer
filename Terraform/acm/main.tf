resource "aws_acm_certificate" "tc-acm" {
  domain_name = "amin-mubarek.com"
  validation_method = "DNS"
}
resource "aws_acm_certificate_validation" "tc_acm_validate" {
  certificate_arn = aws_acm_certificate.tc-acm.arn
}