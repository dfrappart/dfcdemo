
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



