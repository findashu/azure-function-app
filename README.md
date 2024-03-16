# Azure Function App Infra + NodeJs App

This repository serves the purpose of provisioning the essential resources needed for an Azure Function App, followed by the deployment of a Node.js-based HTTP-triggered function application.

## Infra Tech
* Terraform

## Function App
* NodeJs
* Express
* NPM

## Running Locally

### Prerequisites

* Azure Account with an Active Subscription
* Azure CLI
* Terraform CLI


### Execute below commands

```Note : Make sure you are in Infra Directory```

```bash
# login to azure account
az login

terraform init
terraform plan
terraform apply

```