# AWS Control for 303467602807

Terraform control plane for InfraHouse's **CI/CD account** (`303467602807`).

## What It Manages

### IAM Roles

* **Terraform execution roles** (`ih-tf-*`) for CI/CD pipelines
* **CI tester roles** for all InfraHouse Terraform module repositories
  (46 roles defined in `aws_iam_role.tester.tf` via `module-tester-role`)
* **GitHub Actions OIDC integration** for keyless authentication
* **Ubuntu Pro AMI builder role** for `infrahouse-ubuntu-pro` repository

### Networking

* **VPC** (`10.0.0.0/22`) in us-west-1 with public and private subnets
* **Route53 zone** for `ci-cd.infrahouse.com`

### Compute

* **Self-hosted GitHub Actions runner** (ASG-based, `t3a.small`, Ubuntu Noble)

### Storage & Secrets

* **Omnibus cache** S3 bucket
* **GitHub Backup App PEM** secrets (us-west-1, us-west-2, us-east-1)
* **SSM parameters** for GitHub secrets namespace

### Other

* **EC2 serial console access** enabled in us-west-1, us-east-1, us-east-2
* **TwinDB Backup** test runner IAM user and S3 permissions

## Provider Layout

Five AWS provider aliases, all in account `303467602807`:

| Alias                    | Region    |
|--------------------------|-----------|
| Default / `aws-303467602807-uw1` | us-west-1 |
| `aws-303467602807-uw2`  | us-west-2 |
| `aws-303467602807-ue1`  | us-east-1 |
| `aws-303467602807-ue2`  | us-east-2 |

All providers assume the `ih-tf-aws-control-303467602807-admin` role.

State backend is in account `289256138624` (S3 + DynamoDB locking).

## Adding a New Tester Role

1. Add an entry to `local.tester_roles` in `aws_iam_role.tester.tf`:
   ```hcl
   role-name : "github-repo-name"
   ```
2. The role is automatically created with GitHub OIDC trust for `infrahouse/{repo-name}`.

Roles are referenced as `module.ci-tester["role-name"].role_arn`.

## CI/CD

| Workflow              | Trigger        | Purpose                                  |
|-----------------------|----------------|------------------------------------------|
| `terraform-CI.yml`    | Pull requests  | Lint, validate, plan (published via `ih-plan`) |
| `terraform-CD.yml`    | Merge to main  | Download plan artifact, `terraform apply` |
| `vuln-scanner-pr.yml` | Pull requests  | OSV-Scanner for dependency vulnerabilities |

All workflows authenticate via GitHub OIDC (no static credentials).

## Commands

```bash
make lint              # yamllint + terraform fmt -check -recursive
make format            # terraform fmt -recursive
make init              # terraform init
make plan              # terraform init + plan (outputs tf.plan)
make apply             # terraform apply from tf.plan
```

Terraform version is pinned in `.terraform-version`.