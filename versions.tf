terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 5.0.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = ">= 1.0.0"
    }
  }
}
