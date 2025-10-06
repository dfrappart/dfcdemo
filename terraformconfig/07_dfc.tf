


module "defendersetup" {
    source = "../modules/defendersetup"

    mandatory_tags = var.mandatory_tags
    optional_tags = var.optional_tags
    #DefenderCSPMPricing = "Free"
    perimeter = var.DefenderPerimeter
    DefenderLawId = azurerm_log_analytics_workspace.LawMonitor.id

    DefenderCSPMExtension = ["EntraPermissionsManagement", "AgentlessVmScanning"]

}

