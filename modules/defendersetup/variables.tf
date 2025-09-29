###################################################################
#Tag related variables section

variable "mandatory_tags" {
  type = object({
    ApplicativeComponent            = string,
    ApplicativeComponentId          = string,
    ApplicativeComponentStakeholder = string,
    Domain                          = string,
    Environment                     = string,
    RTO                             = string,
    RPO                             = string,
    InternetExposure                = string,
    Lifecycle                       = string,
    Trigramme                       = string

  })
  description = "The mandatory tags must be in any project."
}

variable "optional_tags" {
  type = object({
    ApplicationName        = optional(string)
    ApplicationStakeholder = optional(string)
    Deallocate             = optional(string)
    BackupStrat            = optional(string)
    DataPrivacy            = optional(string)
    PersonalData           = optional(string)
  })
  description = "The optional tags can be in any project."
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "The extra tags that the custmor can add at his project."
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
  default     = "/subscriptions/52e80eb0-cfa5-4da5-86ae-dd4c5bd80474/resourceGroups/rg-defender-prd-001/providers/Microsoft.OperationalInsights/workspaces/law-defender-prd-001"
}

variable "DefenderStaId" {
  type        = string
  description = "The Id of the Defender log analytics workspace"
  default     = "/subscriptions/52e80eb0-cfa5-4da5-86ae-dd4c5bd80474/resourceGroups/rg-defender-prd-001/providers/Microsoft.Storage/storageAccounts/stadefenderprd001"
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