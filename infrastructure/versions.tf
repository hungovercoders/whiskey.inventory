terraform {


  backend "azurerm" {
    key = "whiskey.inventory.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.99.0"
    }
  }

  required_version = ">= 1.2.3"

}

provider "azurerm" {
  features {}
}