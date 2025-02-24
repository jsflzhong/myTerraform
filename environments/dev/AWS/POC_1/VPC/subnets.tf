resource "aws_subnet" "eks_subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.64.0/18"
    availability_zone       = "us-west-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "EKS Subnet"
    }
}

resource "aws_subnet" "rds_subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.128.0/25"
    availability_zone       = "us-west-1a"
    map_public_ip_on_launch = false
    tags = {
        Name = "RDS Subnet"
    }
}

output "subnet_ids" {
    value = [
        aws_subnet.eks_subnet.id,
        aws_subnet.rds_subnet.id
    ]
}
