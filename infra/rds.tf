resource "aws_db_instance" "postgres" {
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  db_name           = "appdb"
  username          = "admin"
  password          = "ReplaceMe123!"
  skip_final_snapshot = true
}