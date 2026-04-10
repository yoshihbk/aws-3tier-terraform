vpc_cidr = "10.0.0.0/16"

azs = [
  "ap-northeast-1a",
  "ap-northeast-1c"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.3.0/24"
]

private_subnet_cidrs = [
  "10.0.2.0/24",
  "10.0.4.0/24"
]

default_tags = {
  Project     = "3tier"
  Environment = "dev"
  Owner       = "yoshihiro"
}
