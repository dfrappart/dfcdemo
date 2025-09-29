##############################################################################
# This file is used to define main resources
##############################################################################

resource "azurerm_security_center_workspace" "DefenderWorkspace" {
  scope        = data.azurerm_subscription.current.id
  workspace_id = var.DefenderLawId
}

resource "azurerm_resource_group" "RGDefender" {
  name     = format("rg-%s-%s-%s-%s", var.perimeter.scope, var.perimeter.environment, "defender", var.perimeter.scope_index)
  location = var.location
  tags     = merge(var.mandatory_tags, var.optional_tags, var.extra_tags)
}


resource "azurerm_storage_account" "STA" {
  name                          = format("sta%s%s%s", var.perimeter.scope, var.perimeter.environment, var.perimeter.scope_index)
  resource_group_name           = azurerm_resource_group.RGDefender.name
  location                      = azurerm_resource_group.RGDefender.location
  account_tier                  = var.sta_config.account_tier
  account_kind                  = var.sta_config.account_kind
  account_replication_type      = var.sta_config.account_replication
  access_tier                   = var.sta_config.access_tier
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = var.sta_config.public_network_access

  tags = merge(var.mandatory_tags, var.optional_tags, var.extra_tags)

}


resource "azurerm_security_center_storage_defender" "DefenderStorage" {
  storage_account_id = azurerm_storage_account.STA.id
}

resource "azurerm_security_center_contact" "DefenderContact" {
  name  = var.DefenderContact.Name
  email = var.DefenderContact.Email

  alert_notifications = var.EnableNotifications
  alerts_to_admins    = var.EnableNotificationsToSubAdmins
}



resource "azurerm_security_center_subscription_pricing" "DefenderPricing" {
  tier          = var.DefenderCSPMPricing
  resource_type = "CloudPosture"
  /*
  extension {
    name = "ContainerRegistriesVulnerabilityAssessments"
  }

  extension {
    name = "AgentlessVmScanning"
    additional_extension_properties = {
      ExclusionTags = "[]"
    }
  }

  extension {
    name = "AgentlessDiscoveryForKubernetes"
  }

  extension {
    name = "SensitiveDataDiscovery"
  }
*/
}

