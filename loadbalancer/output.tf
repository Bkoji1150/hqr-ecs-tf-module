output target_load_id {
  value = aws_alb_target_group.app.id
}

output dns_name {
  value = aws_alb.main.dns_name
}