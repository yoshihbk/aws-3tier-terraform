resource "aws_subnet" "public" {
  for_each = toset(var.azs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[index(var.azs, each.key)]
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    var.default_tags,
    {
      Name = "public-${each.key}"
    }
  )
}

resource "aws_subnet" "private" {
  for_each = toset(var.azs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[index(var.azs, each.key)]
  availability_zone = each.key

  tags = merge(
    var.default_tags,
    {
      Name = "private-${each.key}"
    }
  )
}
