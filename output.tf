# output "azs"{
#     value = data.aws_availability_zones.available.names
# }

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}

output "database_subnet_group_id" {
<<<<<<< HEAD
value = aws_db_subnet_group.db.id
}

output "database_subnet_group_name" {
value = aws_db_subnet_group.db.name
=======
  value = aws_db_subnet_group.db.id
}

output "database_subnet_group_name" {
  value = aws_db_subnet_group.db.name
>>>>>>> a4386f07b31a30de3ac5f29a2cc4a1d6a264bb57
}

output "igw_id" {
  value = aws_internet_gateway.gw.id
}
