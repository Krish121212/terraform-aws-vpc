resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_required ? 1 : 0
  vpc_id        = aws_vpc.main.id  ##requestor VPC
  peer_vpc_id   = var.user_provided_vpcid == "" ? data.aws_vpc.default.id : var.user_provided_vpcid
  auto_accept = var.user_provided_vpcid == "" ? true : false

  tags = merge(
    var.common_tags,
    var.vpc_peering_tags,
    {
        Name = "${local.resource_name}" #expence-dev
    }
  )
}

## expense vpc route tables, here destination is default vpc
resource "aws_route" "public_peering" {
  count = var.is_peering_required && var.user_provided_vpcid == "" ? 1 : 0 #count is useful to control when resurce is required
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "private_peering" {
  count = var.is_peering_required && var.user_provided_vpcid == "" ? 1 : 0 
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

resource "aws_route" "database_peering" {
  count = var.is_peering_required && var.user_provided_vpcid == "" ? 1 : 0 
  route_table_id            = aws_route_table.database_route_table.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

## default vpc route table, here destination is expense vpc
resource "aws_route" "default_peering" {
  count = var.is_peering_required && var.user_provided_vpcid == "" ? 1 : 0 
  route_table_id            = data.aws_route_table.main.id
  destination_cidr_block    = var.vpc_cidr_blocks
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}