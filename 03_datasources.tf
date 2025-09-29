#############################################################################
#This file is used to define data source refering to Azure existing resources
#############################################################################


#############################################################################
#data source for the subscription


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "currentclientconfig" {}

#############################################################################
#data source for azure ad owners

data "azuread_client_config" "current" {}

#############################################################################
#data source for public IP

data "http" "myip" {
  url = "https://ipinfo.io/ip"
}



