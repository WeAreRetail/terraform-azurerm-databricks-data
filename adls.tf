module "private_endpoint_adls" {
  source  = "WeAreRetail/private-endpoint/azurerm"
  version = "1.0.1"

  count = var.private_endpoint && length(var.dns_zone_name) > 0 ? 1 : 0

  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  resource_id         = var.adls.storage_account_id
  caf_prefixes        = var.caf_prefixes

  subresource_names = ["dfs"]
}

module "private_endpoint_adls_blob_dfs" {
  source  = "WeAreRetail/private-endpoint/azurerm"
  version = "1.0.1"

  count = var.private_endpoint && length(var.dns_zone_name) == 0 && can(tostring(var.dns_zones_dfs.dns_group_name)) ? 1 : 0


  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  resource_id         = var.adls.storage_account_id
  caf_prefixes        = var.caf_prefixes

  private_dns_zone_group = [{
    name = var.dns_zones_dfs.dns_group_name
    ids  = var.dns_zones_dfs.dns_zones_ids
  }]

  subresource_names = ["dfs"]
}

module "private_endpoint_adls_blob_blob" {
  source  = "WeAreRetail/private-endpoint/azurerm"
  version = "1.0.1"

  count = var.private_endpoint && length(var.dns_zone_name) == 0 && can(tostring(var.dns_zones_blob.dns_group_name)) ? 1 : 0


  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  resource_id         = var.adls.storage_account_id
  caf_prefixes        = var.caf_prefixes

  private_dns_zone_group = [{
    name = var.dns_zones_blob.dns_group_name
    ids  = var.dns_zones_blob.dns_zones_ids
  }]

  subresource_names = ["blob"]
}

resource "azurerm_private_dns_a_record" "adls" {

  count = var.private_endpoint && length(var.dns_zone_name) > 0 ? 1 : 0

  name                = module.private_endpoint_adls[0].linked_resource_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [module.private_endpoint_adls[0].private_ip]
  tags                = local.parent_tags
}

resource "databricks_mount" "adls" {
  name        = var.adls.name
  resource_id = var.adls.container_id
  abfs {
    client_id              = var.spn_id
    tenant_id              = data.azurerm_client_config.current.tenant_id
    client_secret_scope    = var.databricks_security_scope
    client_secret_key      = var.spn_secret_key #"spn-secret_${data.azurerm_key_vault_secret.spn_id.version}"
    initialize_file_system = true
  }

  depends_on = [
    azurerm_private_dns_a_record.adls,
    var.spn_secret_key
  ]
}
