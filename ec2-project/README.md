# Terraform EC2 Project

This repository deploys a single AWS EC2 instance using Terraform and a local reusable module (`modules/ec2_instance`).

## ✅ What this project creates
- AWS key pair from a local public key file
- AWS security group allowing SSH (22) and HTTP (80) inbound
- AWS EC2 instance in an existing VPC/subnet with that security group
- Outputs EC2 instance public IP

## 📁 Project Structure
```
main.tf
provider.tf
variables.tf
terraform.tfvars
output.tf
modules/ec2_instance/
  main.tf
  variables.tf
  output.tf
```

## ⚙️ Prerequisites
- Terraform installed (v1.x)
- AWS CLI configured (`aws configure`) or `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` environment variables
- Existing VPC and subnet IDs in your AWS account
- Public SSH key file path (for EC2 SSH key pair)

## 🔧 Usage
1. `cd` into this project folder.
2. Copy or create `terraform.tfvars` with your values (example below).
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Preview changes:
   ```bash
   terraform plan
   ```
5. Apply:
   ```bash
   terraform apply
   ```
6. Once complete, note the instance public IP from output.

## 🧩 Example `terraform.tfvars`
```hcl
region        = "us-east-1"
ami_id        = "ami-0c02fb55956c7d316" # replace with your region AMI
instance_type = "t3.micro"
vpc_id        = "vpc-xxxxxxxx"
subnet_id     = "subnet-xxxxxxxx"
public_key    = "~/.ssh/id_ed25519.pub"
```

## 📦 Terraform files reference
- `provider.tf`: AWS provider and region
- `variables.tf`: root variables for configuration
- `main.tf`: calls module `modules/ec2_instance`
- `output.tf`: prints `instance_public_ip`
- `modules/ec2_instance/main.tf`: creates key pair, security group, and EC2 instance
- `modules/ec2_instance/output.tf`: exports instance ID and public IP

## 🙋 Notes
- Security group currently allows SSH and HTTP from anywhere (`0.0.0.0/0`). For production, restrict CIDR ranges.
- `aws_key_pair` is created with static key name `id_ed25519`. If you want dynamic key names, update the module to accept a `key_name` variable.

## 🧹 Cleanup
```bash
terraform destroy
```
