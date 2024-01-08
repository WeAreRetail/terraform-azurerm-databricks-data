variable "adls" {
  type = object({
    storage_account_id = string
    container_id       = string
    name               = string
  })

  description = "Configuration for Databricks mount"
}


variable "caf_prefixes" {
  type        = list(string)
  description = "Prefixes for CAF naming."
}

variable "databricks_security_scope" {
  type        = string
  description = "Security scope for mount secrets."
}

variable "dns_zone_name" {
  type        = string
  default     = ""
  description = "Private link DNS zone name."
}

variable "dns_zones_blob" {
  type = object({
    dns_group_name = string
    dns_zones_ids  = list(string)
  })
  default     = null
  description = "Private link DNS zones ids for blob"
}

variable "dns_zones_dfs" {
  type = object({
    dns_group_name = string
    dns_zones_ids  = list(string)
  })
  default     = null
  description = "Private link DNS zones ids for dfs."
}

variable "private_endpoint" {
  type        = bool
  description = "Create private endpoint to the storage account. Default: true"
  default     = true
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name."
}

variable "spn_id" {
  type        = string
  description = "Spn id"
}

variable "spn_secret_key" {
  type        = string
  description = "Spn Secret key in security scope"
}

variable "subnet_id" {
  type        = string
  description = "Virtual network subnet for endpoints."
}
