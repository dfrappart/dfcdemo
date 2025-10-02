
resource "azurerm_security_center_subscription_pricing" "DefenderCWPPPricing" {

  for_each = {for k, v in var.DefenderCwppPlan : k => v if v.enabled}
  tier          = each.value.plan
  resource_type = each.key
  subplan       = each.value.subplan
}



variable "DefenderCwppPlan" {
  type        = map(object({
    enabled = optional(bool, false)
    plan    = optional(string, "Standard")
    subplan = optional(string, null)

  }))
  description = "The pricing for CWPP, can be Free or Standard"
  default     = {
    "AI" = {
      enabled = true
    },
    "Api" = {
      enabled = true
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
    },
    "VirtualMachines" = {
      enabled = true
      subplan = "P1"
    },
    "Arm" = {
      enabled = true
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