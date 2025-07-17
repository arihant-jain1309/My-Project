module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs = ["us-east-1a", "us-east-1c"]
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "eks"  {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"  # ✅ Stable version
  cluster_name    = var.cluster_name  
  cluster_version = var.cluster_version
  subnet_ids = module.vpc.public_subnet_ids

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
  enable_irsa  = true
}

module "rds" {
  source = "./modules/rds"
  username = var.db_user
  password = var.db_pass
  db_sg_id = aws_security_group.rds_sg.id
    private_subnet_ids = module.vpc.private_subnet_ids
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL access from EKS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "MySQL from EKS"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.cluster_primary_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

