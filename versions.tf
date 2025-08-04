terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.34.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.4.0"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "2.0.1"
    }
  }

  required_version = ">= 0.12"
}
