output "cert_arn" {
  value = aws_acm_certificate_validation.tc_acm_validate.certificate_arn
}

variable "zone_id" {
  
}