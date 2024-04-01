# Template.Azure.Terraform - test

This is a template implementation of how you can deploy Azure infrastructure using Terraform. This repository is designed to be a starting point for your own infrastructure as code projects. You can either use this repo as a template if you want a clean cut-off or fork it to keep up to date with any changes at source.

- [Template.Azure.Terraform - test](#templateazureterraform---test)
  - [Prerequisites](#prerequisites)
  - [Getting Started](#getting-started)
  - [Local Infrastructure Development in Gitpod](#local-infrastructure-development-in-gitpod)
  - [Deployment](#deployment)
  - [Tools Platform](#tools-platform)

## Prerequisites

- [Github Account](https://www.github.com/)
- [Gitpod](https://gitpod.io/)
- [Gitpod Browser Extension](https://www.gitpod.io/docs/configure/user-settings/browser-extension) (optional)
- [Visual Studio Code](https://code.visualstudio.com/) (optional but recommended for any workloads requiring Microsoft VS code extensions)
- [Setup Instructions to Utilise this Repository](https://github.com/hungovercoders/Template.Azure.Terraform/WIKI.md)

## Getting Started

1. Open the repository in gitpod.
2. Note the terminals on the right hand side
   - Versions: Will show you the versions of the tools installed
   - Azure CLI: Will show you the installation of the Azure CLI
   - Azure Storage: Will show you whether the state resource group and storage is created
   - Terraform: Will show you the current terraform plan against the development environment.

## Local Infrastructure Development in Gitpod

1. Make changes in the infrastructure directory.
2. Run the following bash commands to test your changes.

```bash
sh ./tools_platform/infrastructure.sh
```

3. If you wish to try deploying to development from your gitpod directory exactly as the pipeline would, run:

```bash
sh ./tools_platform/infrastructure.sh True
```

## Deployment

1. You can either manually trigger the github action associated with this repo, which will deploy to development and generate a plan against production.
1. A pull request to main will trigger the github action associated with this repo, which will deploy to development and generate a plan against production.
1. A completed pull request to main will trigger the github action associated with this repo, which will deploy to development and deploy to production.

## Tools Platform

In the [tools_platform](./tools_platform/azure.sh), you will find a number of scripts that will help you to manage the infrastructure and environment. These are leveraged in the cloud developer environments (gitpod and codespaces) and as part of the github actions.

- [Azure Login](./tools_platform/azure_login.sh): Logins in to Azure using the CLI using your own credentials.
- [Azure Login Service Principle](./tools_platform/azure_login_service_principal.sh): Logins in to Azure using the CLI using your the service principle setup in your environment variables.
- [Environment Variables](./tools_platform/environment_variables.sh): Displays your environment variables.
- [Environment Versions](./tools_platform/environment_versions.sh): Displays the versions of the tools in your environment.
- [Git Status](./tools_platform/git_status.sh): The current status of your git branches.
- [Infrastructure State Storage](./tools_platform/infrastructure_state_storage.sh): Deploys the storage account in Azure to hold your infrastructure state.
- [Infrastructure](./tools_platform/infrastructure.sh): Plans your infrastructure deploy or deploys it if the argument True is passed.
