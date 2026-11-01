# End To End ECS Threat Composer Project

Table of contents:

1. [Project Overview](#project-overview)
2. [Folder Structure](#foldr-structure)
2. [Architecture Diagram](#architecture-diagram)
3. [Tech Stack](#tech-stack)
4. [Showcase](#showcase)
5. [Key Decisions](#key-decisions)
6. [Run Locally](#run-locally)

## Project Overview
This is a an end to end deployment of AWS managed Threat Composer.

This project demonstrates the understanding of Containerising applications and their dependecies, considering trade-offs in AWS resources for infrastructure and security best practices for a robust and scalable infrastructure and full automation of for developers using pipelines with a shift left approach.

## Folder Structure
```
ECS-TC/
├─ .github/
│  └─ workflows/
│     ├─ cd.yaml
│     ├─ ci.yaml
│     └─ destroy.yaml
├─ app/
│  ├─ config/
│  ├─ public/
│  ├─ src/
│  ├─ .dockerignore
│  ├─ Dockerfile
│  ├─ nginx.conf
│  ├─ package.json
│  ├─ project.json
│  ├─ renovate.json
│  ├─ tsconfig.dev.json
│  ├─ tsconfig.json
│  └─ yarn.lock
├─ bootstrap/
│  ├─ .terraform.lock.hcl
│  ├─ main.tf
│  └─ provider.tf
├─ images/
│  └─ architecture.png
├─ Terraform/
│  ├─ acm/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ alb/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ ecs/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ iam/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ live/
│  │  ├─ dev/
│  │  │  ├─ .terraform.lock.hcl
│  │  │  └─ terragrunt.hcl
│  │  ├─ prod/
│  │  │  └─ terragrunt.hcl
│  │  ├─ staging/
│  │  │  └─ terragrunt.hcl
│  │  └─ root.hcl
│  ├─ route53/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ security_groups/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ vpc/
│  │  ├─ main.tf
│  │  └─ variables.tf
│  ├─ .terraform.lock.hcl
│  ├─ main.tf
│  └─ variables.tf
├─ .gitignore
└─ README.md
```
## Architecture Diagram


<p align="center">
<img src =images/architecture.png alt = "image" height=550px width =500px></img>
</p>

## Tech Stack

### Docker -
* 

### Terraform --> Terragrunt
* 

### AWS
* 

### Github Actions
* 



## Showcase

### Domain Showcase

### 

## Key decisions


## Run Locally

### Build:
```bash
cd app
docker build -t <image-name><tag>  .
docker run  -p 8080:80 -d <image-name><tag>
```
### Terragrunt Commands:
```bash
cd Terraform/live/<environment-of-choice>
Terragrunt init
Terragrunt plan
Terragrunt apply --auto-approve
