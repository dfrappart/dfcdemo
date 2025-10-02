
#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}