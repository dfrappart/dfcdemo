
resource "azurerm_security_center_automation" "continuous_export" {
  description         = null
  enabled             = true
  location            = var.location
  name                = "ExportToWorkspace"
  resource_group_name = azurerm_resource_group.RGDefender.name
  scopes              = [data.azurerm_subscription.current.id]

  tags                = {}
  
  action {
    resource_id       = var.DefenderLawId
    type              = "Workspace"
  }


  dynamic "source" {
    for_each = var.DefenderContinuousExportMap

    content {
      event_source = source.value.EventSource

      dynamic "rule_set" {
        for_each = source.value.RuleSets
        content {
          rule {
            expected_value = rule_set.value.ExpectedValue
            operator       = rule_set.value.Operator
            property_path  = rule_set.value.PropertyPath
            property_type  = rule_set.value.PropertyType
          }
        }
      }
    }
    
  }

  


}
