######################################################
# Variables
######################################################

##############################################################
#Variable declaration for provider

variable "AzureSubscriptionID" {
  type        = string
  description = "The subscription id for the authentication in the provider"
}




variable "AzureClientID" {
  type        = string
  description = "The application Id, taken from Azure AD app registration"
}


variable "AzureClientSecret" {
  type        = string
  description = "The Application secret"

}

variable "AzureTenantID" {
  type        = string
  description = "The Azure AD tenant ID"
}


variable "AzureADClientSecret" {
  type        = string
  description = "The AAD Application secret"

}

variable "AzureADClientID" {
  type        = string
  description = "The AAD Client ID"
}



######################################################
# Common variables

variable "AzureRegion" {
  type        = string
  description = "The region for the Azure resource"
  default     = "francecentral"

}

###################################
# tags

variable "mandatory_tags" {
  type = object({
    data_classification  = optional(string, null)
    operation_commitment = optional(string, null)
    usage                = optional(string, null)
    start_time           = optional(string, null)
    stop_time            = optional(string, null)

  })

  default = {}
}

variable "optional_tags" {
  type = object({
    owner      = optional(string, "N/A")
    start_date = optional(string, "N/A")

  })
  default = {}
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}

######################################################
# Data sources variables


######################################################
# Rg variables

variable "RgConfig" {
  type = map(object({
    RgLocation = string


  }))

  default = {
    "rsg-monitor" = {
      RgLocation = "francecentral"
    }
    "rsg-security" = {
      RgLocation = "francecentral"
    }
    "rsg-kv" = {
      RgLocation = "francecentral"
    }
    "rsg-dns" = {
      RgLocation = "francecentral"
    }
    "rsg-acr" = {
      RgLocation = "francecentral"
    }
  }
}

