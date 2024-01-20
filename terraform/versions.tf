terraform {


  backend "azurerm" {
    key = "template.azure.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.84.0"
    }
  }

  required_version = ">= 1.2.3"

}

provider "azurerm" {
  features {}
}
