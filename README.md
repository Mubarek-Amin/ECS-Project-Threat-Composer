# End To End ECS Threat Composer Project

## Table of contents:

1. [Project Overview](#project-overview)
2. [Architecture Diagram](#architecture-diagram)
3. [Folder Structure](#folder-structure)
4. [Tech Stack](#tech-stack)
5. [Showcase](#showcase)
6. [Key Decisions](#key-decisions)
7. [Run Locally](#run-locally)

## Project Overview
### This is an end to end deployment of AWS managed Threat Composer.

This project demonstrates the understanding of Containerising applications and their dependencies, considering trade-offs in AWS resources for infrastructure and security best practices for a robust and scalable infrastructure and full automation for developers using pipelines with a shift left approach.
## Architecture Diagram


<p align="center">
<img src =images/architecture.png alt = "image" height=550px width =500px></img>
</p>

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

## Tech Stack

### Docker -
* Multi-Stage docker build **reducing** image size from **600mb** to **70mb**

* `node:20-bookworm-slim` base build image to package build dependencies as the most compatible base image for a `node.js` app

* `nginx:alpine` runtime serving the static build - dropping Node at runtime + the alpine base cut image CVEs from 74 to 4

### Terraform --> Terragrunt -
*  Modular Terraform: vpc, alb, ecs, acm, route53, security_groups, iam — composed per environment

* Terragrunt for DRY multi-env (dev/staging/prod): one module set + thin per-env inputs, not three drifting copies

* Remote S3 state with native locking, a separate state key per env

* `Bootstrap/` provisions the ECR repo, the state bucket (versioning + SSE + enforced-TLS policy), and the OIDC provider + role


### AWS -
* ECS Fargate (serverless containers) behind a public ALB

* VPC with public + private subnets across 2 AZs - ensuring High Availability

* ACM + Route 53 for HTTPS on amin-mubarek.com

* ECR for images, CloudWatch Logs for task logs

* Security groups scoped so only the ALB can reach the tasks


### Github Actions -
#### CI 
*  Checkout (fetch-depth 0) → CodeQL SAST → Terraform fmt/validate + Trivy IaC scan → docker build (tagged with commit SHA) → Trivy image scan as a gate → push to ECR


#### CD
* OIDC assume-role (keyless — no AWS keys stored in GitHub) → install terraform + terragrunt → terragrunt apply → ECS rolling (zero-downtime) deploy of the SHA-tagged image



## Showcase

### Domain Showcase :
<p align="center">
<img src =images/Showcase1.png alt = "image" height=350px width =650px></img>
</p>

### Path Showcase :
<p align="center">
<img src =images/Showcase2.png alt = "image" height=350px width =650px></img>
</p>


## Key decisions

* Why `nginx:alpine` as the runtime image?
    * Threat Composer is a static frontend — it needs no Node at runtime. nginx:alpine serves the built files directly, which shrank the image and cut CVEs 74 → 4. A try_files rule located in `app/nginx.conf` handles SPA client-side routing.

* Why **Terragrunt**?
    * DRY across environments. dev/staging/prod share **~90% of config**, so plain Terraform means three copies that drift. Terragrunt keeps one module set and points thin per-env inputs at it.

* **OIDC** instead of static key?
    * Yes because this means **NO** long-lived AWS credentials are stored in GitHub. GitHub mints a short-lived token per run; AWS's trust policy only accepts it from this repo (scoped on the sub claim). Nothing to leak, nothing to rotate.
## Run Locally

### Build:
```bash
cd app
docker build -t <image-name>:<tag>  .
docker run  -p 8080:80 -d <image-name>:<tag>
```
### Terragrunt Commands:
```bash
cd Terraform/live/<environment-of-choice>
terragrunt init
terragrunt plan
terragrunt apply --auto-approve
```