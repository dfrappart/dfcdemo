
resource "azurerm_security_center_subscription_pricing" "mdc_arm" {
  tier          = "Standard"
  resource_type = "Arm"
  subplan       = "PerApiCall"
}