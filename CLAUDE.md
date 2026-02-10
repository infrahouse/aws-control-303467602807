# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## First Steps

**Your first tool call in this repository MUST be reading .claude/CODING_STANDARD.md.
Do not read any other files, search, or take any actions until you have read it.**
This contains InfraHouse's comprehensive coding standards for Terraform, Python, and general formatting rules.

## What This Repository Is

AWS account control plane for InfraHouse's CI/CD account (303467602807). It manages:
- Terraform execution roles (`ih-tf-*`)
- GitHub Actions OIDC integration
- CI tester roles for all InfraHouse Terraform module repositories
- Shared infrastructure (VPC, Route53, S3 buckets, SSM parameters)

## Common Commands

```bash
make lint              # yamllint + terraform fmt -check -recursive
make format            # terraform fmt -recursive
make init              # terraform init
make plan              # terraform init + plan (outputs tf.plan)
make apply             # terraform apply from tf.plan
make bootstrap         # pip install requirements.txt (dev dependencies)
make bootstrap-ci      # pip install requirements-ci.txt (CI dependencies)
```

Terraform version is pinned in `.terraform-version` (currently 1.14.1).

## Architecture

### Provider Layout

Four AWS provider aliases, all in account 303467602807, assuming the `ih-tf-aws-control-303467602807-admin` role:
- Default / `aws-303467602807-uw1` (us-west-1)
- `aws-303467602807-ue1` (us-east-1)
- `aws-303467602807-ue2` (us-east-2)

State backend is in a separate account (289256138624) with S3 + DynamoDB locking.

### Tester Role Pattern

`aws_iam_role.tester.tf` defines a `tester_roles` local map. Each entry creates a CI tester IAM role via `./modules/module-tester-role` using `for_each`. To add a new tester role:
1. Add an entry to `local.tester_roles`: `role-name : "github-repo-name"`
2. The role is automatically created with GitHub OIDC trust for `infrahouse/{repo-name}`.

Roles are referenced as `module.ci-tester["role-name"].role_arn`.

### Local Modules (in `modules/`)

- **module-tester-role** - Reusable IAM role for GitHub Actions OIDC-based CI testing
- **ci-cd.infrahouse.com** - Route53 zone
- **omnibus-cache** - Public S3 cache bucket
- **infrahouse-ubuntu-pro-regional** - Ubuntu Pro AMI build infrastructure per region (KMS, SSH keys, SSM params)

### Registry Modules

InfraHouse modules use `registry.infrahouse.com` (e.g., `infrahouse/service-network/aws`, `infrahouse/secret/aws`). External modules use the public Terraform registry.

### Key Locals

Defined in `locals.tf`:
- `me_arn` - IAM user ARN for the repository owner
- `environment` - Set to `"development"`

## CI/CD

- **terraform-CI.yml** (PRs): lint, terraform validate, terraform plan, publish plan via `ih-plan`
- **terraform-CD.yml** (merge to main): download plan, terraform apply
- **vuln-scanner-pr.yml**: OSV-Scanner for dependency vulnerabilities

All CI workflows authenticate via GitHub OIDC role assumption (no static credentials).