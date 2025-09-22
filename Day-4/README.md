# 🗃️ Terraform Remote Backend on AWS

This project provisions the infrastructure required to use a **remote backend** for Terraform state management using **Amazon S3** and **DynamoDB**.

##  What This Project Does

- Creates an **S3 bucket** to securely store Terraform state files.
- Enables **versioning** on the S3 bucket to track historical state changes.
- Creates a **DynamoDB table** to manage **state locking and consistency**, preventing concurrent operations.
- Optionally configures **encryption** and **bucket policies** for secure access.

## Components

- **main.tf** – Terraform code to create the S3 bucket and DynamoDB table.
- **variables.tf** – Input variable definitions (e.g., bucket name, region, table name).
- **terraform.tfvars** – Variable values specific to your environment.
- **backend.tf (or commented backend block)** – To be used in other Terraform projects for connecting to this backend.
- **README.md** – Project description and structure.

##  Concepts Demonstrated

- Use of **remote state** to improve collaboration and reliability
- **S3 versioning** for tracking changes to `terraform.tfstate`
- **DynamoDB locking** to avoid concurrent apply conflicts
- Modular and reusable backend setup using Terraform

##  Use Case

This project serves as a template or foundational setup for:

- Teams using Terraform collaboratively
- CI/CD pipelines requiring consistent and remote state storage
- Projects needing scalable and secure Terraform state handling

Once deployed, other Terraform projects can use the backend by referencing:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-backend-bucket"
    key            = "project-name/terraform.tfstate"
    region         = "your-region"
    dynamodb_table = "your-lock-table"
  }
}

