# AWS VPC Project (Terraform)

A simple Terraform project to create an AWS VPC with:
- One VPC
- One public subnet
- One private subnet
- Internet Gateway (IGW)
- Public route table with Internet access
- NAT Gateway in public subnet
- Private route table using NAT for outbound internet access

## Files
- `main.tf` : Terraform resources for VPC, subnets, gateways, and routes.
- `variables.tf` : CIDR block variables for VPC and subnets.
- `terraform.tfstate` / `terraform.tfstate.backup` : Terraform state (managed by Terraform).

## Prerequisites
1. Install Terraform (v1.0+ recommended).
2. Configure AWS credentials (`~/.aws/credentials` or environment variables).
3. Ensure `aws` provider has access to `ap-south-1` or modify region in `main.tf`.

## Terraform Commands
From this project directory:

```bash
terraform init
terraform plan
terraform apply
```

To destroy the infrastructure:

```bash
terraform destroy
```

## Variables
The defaults are in `variables.tf`:
- `VPC_CIDR` (default: `10.0.0.0/16`)
- `PUBLIC_SUBNET_CIDR` (default: `10.0.1.0/24`)
- `PRIVATE_SUBNET_CIDR` (default: `10.0.2.0/24`)

You can override variables using `-var`:

```bash
terraform apply -var='VPC_CIDR=10.1.0.0/16' -var='PUBLIC_SUBNET_CIDR=10.1.1.0/24' -var='PRIVATE_SUBNET_CIDR=10.1.2.0/24'
```

## Architecture Summary
1. Create VPC.
2. Create public and private subnet in the same VPC.
3. Attach Internet Gateway to VPC.
4. Create public route table with route `0.0.0.0/0` to IGW.
5. Create NAT Gateway in public subnet and attach it to private route table.
6. Private subnet routes outbound traffic through NAT Gateway.

## Notes
- This setup is a basic AWS networking pattern for web-facing and backend-private resources.
- Add security groups and EC2 resources in future iterations if needed.


