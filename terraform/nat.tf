resource "aws_eip" "nat" {
  vpc = true

  tags = merge(
    var.default_tags,
    {
      Name = "nat-eip"
    }
  )
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public["ap-northeast-1a"].id

  tags = merge(
    var.default_tags,
    {
      Name = "nat-gateway"
    }
  )
}
