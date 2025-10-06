



resource "azurerm_security_center_automation" "continuous_export" {
  name                = "ExportToWorkspace"
  location            = var.location
  resource_group_name = azurerm_resource_group.RGDefender.name
  enabled = true

  action {
    type        = "loganalytics"
    resource_id = var.DefenderLawId
  }

  source {
    event_source = "Alerts"
    rule_set {
      rule {
        property_path  = "Severity"
        operator       = "Equals"
        expected_value = "high"
        property_type  = "String"
      }
    }
    rule_set {
      rule {
        property_path  = "Severity"
        operator       = "Equals"
        expected_value = "medium"
        property_type  = "String"
      }
    }
    rule_set {
      rule {
        property_path  = "Severity"
        operator       = "Equals"
        expected_value = "low"
        property_type  = "String"
      }
    }
  }

  dynamic "source" {
    for_each = var.DefenderContinuousExportsources

    content {
      event_source = source.value
    }
  }

  scopes = [data.azurerm_subscription.current.id]
}

variable "DefenderContinuousExportsources" {
  type = set(string)

  default = [ 
    #"Alerts",
    "SecureScores",
    #"SecureScoreControls",
    #"RegulatoryComplianceAssessment",
    #"SubAssessments",
    #"Assessments"
  ]
}