# 🌐 Terraform AWS EC2 Infrastructure Project

This project uses **Terraform** to provision a basic web server infrastructure on **Amazon Web Services (AWS)**. It demonstrates how to automate the creation of network and compute resources required to deploy a simple Flask-based web application.

## 🔧 What This Project Does

- Creates a **Virtual Private Cloud (VPC)** with a custom CIDR block.
- Configures a **public subnet** within the VPC.
- Sets up an **Internet Gateway** for outbound internet access.
- Creates a **Route Table** and associates it with the public subnet.
- Launches an **EC2 instance** in the public subnet with:
  - SSH key access
  - A public IP
  - Flask installed via remote provisioning
  - A `app.py` Python web application automatically copied and run on boot
- Sets up a **Security Group** to allow HTTP (port 80) and SSH (port 22) access.
- Uses **Terraform provisioners** to upload and start the Flask app on the instance.

## 📂 Components

- **main.tf** – Defines all AWS infrastructure resources.
- **app.py** – A basic Flask application that runs on the EC2 instance.
- **variables.tf** – Input variable definitions (e.g., AMI ID, region, CIDRs).
- **terraform.tfvars** – Values assigned to variables.
- **README.md** – Project overview and details.

## 🧠 Concepts Demonstrated

- Infrastructure as Code (IaC) using Terraform
- AWS networking fundamentals (VPC, Subnet, Route Tables)
- EC2 instance provisioning and remote execution
- Basic security practices using key pairs and security groups
- Lightweight web server deployment with Flask

## 🌍 Use Case

This project serves as a foundational template for:

- Learning Terraform with real AWS resources
- Deploying simple web applications in the cloud
- Demonstrating end-to-end provisioning from infrastructure to application deployment

---


