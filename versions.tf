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
  }

  required_version = ">= 0.12"
}