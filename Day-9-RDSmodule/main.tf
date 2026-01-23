module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodbbb"
  username = "user"
  port     = "3306"

  #iam_database_authentication_enabled = true
   manage_master_user_password = true

  vpc_security_group_ids = ["sg-04bf5b3f416bd957b"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  
  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  #monitoring_interval    = "30"
  #monitoring_role_name   = "MyRDSMonitoringRole"
  #create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-09d7807edc3c57a1c", "subnet-083ad5cf5ff79b7be"]

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true

  
  
}