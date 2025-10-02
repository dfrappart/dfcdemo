###################################################################
#Tag related variables section

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

variable "perimeter" {
  type = object({
    environment = string
    scope       = string
    scope_index = optional(string, "001")
  })
}

##############################################################################
# Defender variables
##############################################################################

variable "DefenderLawId" {
  type        = string
  description = "The Id of the Defender log analytics workspace"
}



variable "sta_config" {
  type = object({
    location              = optional(string, "francecentral")
    account_tier          = optional(string, "Standard")
    access_tier           = optional(string, "Hot")
    account_kind          = optional(string, "StorageV2")
    account_replication   = optional(string, "LRS")
    public_network_access = optional(bool, true)

  })

  default = {
    location = "francecentral"
  }

}



variable "location" {
  description = "Define the location of the resources"
  default     = "francecentral"
  type        = string
}

variable "DefenderContact" {
  type = object({
    Name  = string
    Email = string

  })

  description = "An object to define the Defender contact"

  default = {
    Name  = "CloudTeam"
    Email = "david.frappart.externe@cnp.fr"
  }
}

variable "EnableNotifications" {
  type        = bool
  default     = true
  description = "A bool to enable security alert to be send to security contacts"
}

variable "EnableNotificationsToSubAdmins" {
  type        = bool
  default     = false
  description = "A bool to enable security alert to be send to subscription admins"
}

variable "DefenderCSPMPricing" {
  type        = string
  description = "The pricing for CSPM, can be Fee or Standard"
  default     = "Standard"
}