

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric = true
  keepers = {
    # Generate a new suffix only when the resource group name changes
    rg_name = azurerm_resource_group.RGShared["rsg-kv"].name
  }
}

resource "azurerm_key_vault" "Kv" {

  rbac_authorization_enabled      = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = azurerm_resource_group.RGShared["rsg-kv"].location
  name                            = "kvlab${random_string.suffix.result}"
  public_network_access_enabled   = true
  purge_protection_enabled        = true
  resource_group_name             = azurerm_resource_group.RGShared["rsg-kv"].name
  sku_name                        = "standard"
  soft_delete_retention_days      = 90
  tags                            = {}
  tenant_id                       = var.AzureTenantID
  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
    ip_rules = [
      "${data.http.myip.response_body}/32"
    ]

    virtual_network_subnet_ids = []
  }
}

resource "azurerm_monitor_diagnostic_setting" "KvDiagSettings" {
  name                       = format("%s-%s", "diag", azurerm_key_vault.Kv.name)
  storage_account_id         = azurerm_storage_account.StaMonitor.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.LawMonitor.id
  target_resource_id         = azurerm_key_vault.Kv.id


  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.keyvaultdiag.log_category_types
    content {
      category = enabled_log.value

    }
  }

  lifecycle {
    ignore_changes = [metric]
  }

}

resource "random_string" "suffixstasample" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric = true
  keepers = {
    # Generate a new suffix only when the resource group name changes
    rg_name = azurerm_resource_group.RGShared["rsg-kv"].name
  }
}


resource "azurerm_storage_account" "STASample" {
  name                          = "stalab${random_string.suffixstasample.result}"
  resource_group_name           = azurerm_resource_group.RGShared["rsg-security"].name
  location                      = azurerm_resource_group.RGShared["rsg-security"].location
  account_tier                  = var.StaConfig.account_tier
  account_kind                  = var.StaConfig.account_kind
  account_replication_type      = var.StaConfig.account_replication
  access_tier                   = var.StaConfig.access_tier
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = var.StaConfig.public_network_access

  tags = merge(var.mandatory_tags, var.optional_tags, var.extra_tags)

}