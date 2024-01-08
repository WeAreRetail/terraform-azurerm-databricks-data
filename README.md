# Azure Aware Databricks Data

[![Build Status](https://dev.azure.com/weareretail/Tooling/_apis/build/status/mod_azu_databricks_data?repoName=mod_azu_databricks_config&branchName=master)](https://dev.azure.com/weareretail/Tooling/_build/latest?definitionId=11&repoName=mod_azu_databricks_data&branchName=master)[![Unilicence](https://img.shields.io/badge/licence-The%20Unilicence-green)](LICENCE)

Common Azure Terraform module to normalize Azure Databricks config setup.

# Usage

```hcl
module "adls_connexions_datamart" {
  source = "./modules/mod_azu_databricks_data"
  providers = {
    databricks = databricks
  }
  for_each = local.datamart_adls_array

  resource_group_name       = local.resource_group_name
  caf_prefixes              = module.naming_data.resource_prefixes
  subnet_id                 = local.endpoint_subnet_id
  spn_id                    = module.databricks_config.spn_id_value
  spn_secret_key            = module.databricks_config.spn_secret_key
  databricks_security_scope = module.databricks_config.security_scope

  dns_zones_dfs = {
    dns_group_name = "privatelink.dfs.core.windows.net"
    dns_zones_ids  = [data.azurerm_private_dns_zone.privatelink_dfs.id]
  }

  dns_zones_blob = {
    dns_group_name = "privatelink.blob.core.windows.net"
    dns_zones_ids  = [data.azurerm_private_dns_zone.privatelink_blob.id]
  }

  adls = {
    storage_account_id = each.key
    container_id       = each.value.container_id
    name               = "${each.value.name}-${each.value.environment}"
  }
}
```

***Autogenerated file - do not edit***

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.13.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.0.0 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adls"></a> [adls](#input\_adls) | n/a | <pre>object({<br>    storage_account_id = string<br>    container_id       = string<br>    name               = string<br>  })</pre> | n/a | yes |
| <a name="input_caf_prefixes"></a> [caf\_prefixes](#input\_caf\_prefixes) | Prefixes for CAF naming. | `list(string)` | n/a | yes |
| <a name="input_databricks_security_scope"></a> [databricks\_security\_scope](#input\_databricks\_security\_scope) | n/a | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | Private link DNS zone name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. | `string` | n/a | yes |
| <a name="input_spn_id"></a> [spn\_id](#input\_spn\_id) | Spn id | `string` | n/a | yes |
| <a name="input_spn_secret_key"></a> [spn\_secret\_key](#input\_spn\_secret\_key) | Spn Secret key in security scope | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Virtual network subnet for endpoints. | `string` | n/a | yes |

#### Outputs

No outputs.
