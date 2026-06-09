output "public_subnet_ids" {
  value = aws_subnet.pub1a[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.pri1a[*].id
}

output "sg" {
  value = aws_security_group.sg.id
}