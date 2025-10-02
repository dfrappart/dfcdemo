
resource "azurerm_security_center_subscription_pricing" "DefenderCWPPPricing" {

  for_each = {for k, v in var.DefenderCwppPlan : k => v if v.enabled}
  tier          = each.value.plan
  resource_type = each.key
  subplan       = each.value.subplan
  dynamic "extension" {
    for_each = each.value.extension
    content {
      name = extension.value
    }
    
  }
}



variable "DefenderCwppPlan" {
  type        = map(object({
    enabled = optional(bool, false)
    plan    = optional(string, "Standard")
    subplan = optional(string, null)
    extension = optional(set(string), [])



  }))
  description = "The pricing for CWPP, can be Free or Standard"
  default     = {
    "AI" = {
      enabled = true
    },
    "Api" = {
      enabled = false
      subplan = "P1"
    },
    "AppServices" = {
      enabled = false
    },
    "ContainerRegistry" = {
      enabled = false
    },
    "KeyVaults" = {
      enabled = true
      subplan = "PerKeyVault"
    },
    "KubernetesService" = {
      enabled = false
    },
    "SQLServers" = {
      enabled = false
    },
    "SqlServerVirtualMachines" = {
      enabled = false
    },
    "StorageAccounts" = {
      enabled = true
      subplan = "DefenderForStorageV2"
    },
    "VirtualMachines" = {
      enabled = true
      subplan = "P1"
    },
    "Arm" = {
      enabled = true
      subplan = "PerSubscription"
    },
    "Dns" = {
      enabled = true
    },
    "OpenSourceRelationalDatabases" = {
      enabled = false
    },
    "Containers" = {
      enabled = true
    },
    "CosmosDB" = {
      enabled = false
    },
  }
}