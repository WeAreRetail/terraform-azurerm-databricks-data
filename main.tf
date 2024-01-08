
locals {
  parent_tags = { for n, v in data.azurerm_resource_group.parent_group.tags : n => v if n != "description" }
}

data "azurerm_client_config" "current" {
}


data "azurerm_resource_group" "parent_group" {
  name = var.resource_group_name
}
