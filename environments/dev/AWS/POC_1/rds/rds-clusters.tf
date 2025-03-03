resource "aws_rds_cluster" "main" {
    cluster_identifier      = "main-cluster"
    engine                  = "aurora"
    engine_version          = "5.6.10a"
    master_username         = "admin"
    master_password         = "password"
    database_name           = "mydb"
    db_subnet_group_name    = aws_rds_subnet_group.main.name
    multi_az                = true
    storage_encrypted       = true
    backup_retention_period = 7

    tags = {
        Name = "MainRDSCluster"
    }
}

resource "aws_rds_subnet_group" "main" {
    name       = "main-db-subnet-group"
    subnet_ids = module.vpc.subnet_ids
}
