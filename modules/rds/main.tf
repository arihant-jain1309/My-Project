resource "aws_db_subnet_group" "this" {
  name = "my-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "my-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage = 20 
  engine = "mysql"
  engine_version = "8.0"
  instance_class  = "db.t3.micro"
  username = var.username
  password = var.password
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot = true
  publicly_accessible = false 
}
