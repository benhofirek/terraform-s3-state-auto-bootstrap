# 🏗️ Terraform S3 state auto boostrap

A project demonstrating how to bootstrap an AWS S3 state backend, migrate local state into it, and clean up temporary local artifacts with a single CLI command using **Task** (`Taskfile.yml`) and **OpenTofu** (`tofu`).

## ⚙️ How It Works

Bootstrapping remote state usually takes manual steps across separate directories. The `tf-init` task automates the full sequence:

1. **Preconditions check:** Verifies `TF_VAR_state_bucket_name` and `TF_VAR_aws_region` are set, and checks whether the S3 backend is already reachable so task run idempotently.
2. **Bootstrap & bucket creation:** Initializes `./infrastructure/bootstrap` and applies it (`-auto-approve`) to provision the S3 state bucket.
3. **State migration:** Copies the bootstrap `terraform.tfstate` into `./infrastructure/main` and runs `tofu init -migrate-state -force-copy` to move state into the S3 backend.
4. **Verification:** Confirms remote state access with `tofu state list`

## 📋 Prerequisites

- **Recommended — Nix & direnv:** Install [Nix](https://nix.dev/install-nix) and [direnv](https://github.com/nix-community/nix-direnv#installation), then run `direnv allow` in the project root. `.envrc` and `flake.nix` automatically provide the required CLI dependencies (`task`, `tofu`, AWS tooling, etc.).
- **AWS credentials:** Configured in your environment (for example via `aws login`) with permissions to create the state bucket and access S3.

## ⚡ Quick Start

1. **Create your `.env` file** from the example template:

   ```bash
   cp .example.env .env
   ```

2. **Set required variables in `.env`**, including:
   - `TF_VAR_state_bucket_name` — unique name for the S3 state bucket
   - `TF_VAR_aws_region` — target AWS region

3. **Run initialization task:**

   ```bash
   task tf-init
   ```

## 📁 Project Structure

```text
.
├── .envrc                 # direnv integration (loads flake.nix environment)
├── .example.env           # Template for required environment variables
├── flake.nix              # Reproducible dev shell and tool dependencies
├── Taskfile.yml           # Task definitions (`tf-init` and internal `cleanup`)
└── infrastructure/
    ├── bootstrap/         # Provisions the S3 state bucket
    └── main/              # Target configuration using the S3 backend
```
