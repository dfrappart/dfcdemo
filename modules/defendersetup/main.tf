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



resource "azurerm_security_center_contact" "DefenderContact" {
  name  = var.DefenderContact.Name
  email = var.DefenderContact.Email

  alert_notifications = var.EnableNotifications
  alerts_to_admins    = var.EnableNotificationsToSubAdmins
}



resource "azurerm_security_center_subscription_pricing" "DefenderCSPMPricing" {
  tier          = var.DefenderCSPMPricing
  resource_type = "CloudPosture"

  dynamic "extension" {
    for_each = var.DefenderCSPMExtension
    content {
      name = extension.value
    }
    
  }
}
