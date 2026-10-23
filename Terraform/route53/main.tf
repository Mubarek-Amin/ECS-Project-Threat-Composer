resource "aws_route53_record" "tc_record" {
    name = "amin-mubarek.com"
    zone_id = var.zone_id
    type = "A"
    alias {
        name = var.alb_dns_name
        zone_id = var.alb_zone_id
        evaluate_target_health = true

    }
  
}