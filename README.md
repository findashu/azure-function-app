# Azure Function App Infra + NodeJs App

This repository serves the purpose of provisioning the essential resources needed for an Azure Function App, followed by the deployment of a Node.js-based HTTP-triggered function application.

## Infrastructure Tech
* Terraform

## Function App
* NodeJs
* Express
* NPM

## CI/CD
* Github Actions

## Repo Structure

Repository includes 3 main directories

* `.github`: Includes pipeline files
* `Application`: Includes nodejs function app
* `Infra`: Includes terraform files to deploy Infrastructure.

```Bash
├── azure-function-app
│   ├── .github
│   │   ├── **/*.yml
├── Application
│   ├── UserFa
│   │   ├── index.js
│   │   ├── function.json
├── Infra
│   │   ├── main.tf
└── .gitignore

```

### Prerequisites

* Azure Account with an Active Subscription
* Azure CLI
* Terraform CLI


### Deploy Infra Locally

> [!NOTE]
> Make sure you are in Infra Directory

```bash
# login to azure account
az login

terraform init
terraform plan
terraform apply

```

### Infrastructure

In the repository, Terraform is set up to utilize an Azure Storage Account as a backend to store the state file. If you prefer not to use a remote backend, you can safely remove the following code block from `Infra/main.tf`

> [!TIP]
> It's good to use remote backend for production env.

```terraform
backend "azurerm" {
    resource_group_name  = "Infra-Resource"
    storage_account_name = "configterraformsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
```

### Github Actions

```
├── azure-function-app
│   ├── .github
│   │   ├── tf-unit-tests.yml
│   │   ├── tf-plan/apply.yml
│   │   ├── tf-destriy.yml

```
### Unit Test

This action is triggered by any push to a branch, specifically checking for changes within the Infra directory. This ensures that unnecessary runs are avoided when there are no changes in the Infra. The pipeline then proceeds to conduct basic testing using Terraform commands.

### Terraform Plan and Apply

This has 2 Jobs to run based on conditions.

#### Plan
Upon the raising of a pull request and the presence of changes within the Infra directory, this process automatically executes. Upon successful completion, it appends the Terraform plan to the pull request for review.

#### Apply

This process is initiated either upon the merging of a pull request into the main branch or if there are direct changes made to the main branch. It then proceeds to deploy the infrastructure as defined in the main.tf file.

### Terraform Destroy

This action is manually triggered to clean up resources after a successful test on lower environments.