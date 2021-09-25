output vpc_id {
  description = "this is an output of the vpc id"
  value = aws_vpc.main.id
}

output pub-cidr-sub {
  description = "this is an output of the publich subnet cidr"
  value = aws_subnet.public.*.id
}

output priv-cidr-sub {
  description = "this is an output of the private subnet cidr"
  value = aws_subnet.private.*.id
}
