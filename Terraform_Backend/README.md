# Terraform Remote Backend Demo

This repository demonstrates a minimal Terraform module for an AWS EC2 instance while configuring a remote backend.

## Files

- `main.tf` - AWS provider + `aws_key_pair` and `aws_instance` resources.
- `backend.tf` - Terraform remote backend configuration.
- `README.md` - usage and remote backend instructions.

## Prerequisites

1. Install Terraform (v1.4+).
2. AWS credentials configured locally (`aws configure` or env vars).
3. SSH public key available (e.g. `~/.ssh/id_ed25519.pub`).
4. Remote backend workspace ready (e.g. S3 bucket + DynamoDB table for locking, or Terraform Cloud workspace).

## Example remote backend (S3)

In `backend.tf`:


terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "terraform_backend_example/terraform.tfstate"
    region         = "ap-south-1"
  }
}



## Setup

1. Update `backend.tf` backend values (bucket/workspace etc.).
2. Set AWS credentials and region.
3. Confirm `main.tf` values (AMI, subnet_id, instance_type, tags).

## Workflow

```bash
terraform init
terraform plan
terraform apply
```

Terraform will initialize with remote state and store state remotely.

## Verify state backend

Run:

```bash
terraform show
```

Your state should be stored in configured backend location.

## Destroy

```bash
terraform destroy
```

## `main.tf` highlights

- `aws_key_pair.demo` creates key pair from local public key.
- `aws_instance.demo` launches EC2 with `subnet_id` and `key_name = aws_key_pair.demo.key_name`.
- Use `tags` map for resource tagging.


