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
    Email = "david@teknews.cloud"
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

variable "DefenderCSPMExtension" {
  type        = set(string)
  description = "The extensions for CSPM"
  default     = [
    "EntraPermissionsManagement",
    "AgentlessVmScanning"
    ]
}

variable "DefenderContinousExportEnabled" {
  type        = bool
  default     = true
  description = "A bool to enable or disable the continuous export"
}

variable "DefenderContinuousExportName" {
  type        = string
  default     = "ExportToWorkspace"
  description = "The name of the continuous export"
}

variable "DefenderContinuousExportMap" {
  type = map(object({
    EventSource = string
    RuleSets = optional(map(object({
      PropertyPath  = string
      Operator      = string
      ExpectedValue = string
      PropertyType  = string
    })), {})
  }))

  default = {
    "Alerts" = {
      EventSource = "Alerts"
      RuleSets = {
        "High" = {
          PropertyPath  = "Severity"
          Operator      = "Equals"
          ExpectedValue = "high"
          PropertyType  = "String"
        }
        "Medium" = {
          PropertyPath  = "Severity"
          Operator      = "Equals"
          ExpectedValue = "medium"
          PropertyType  = "String"
        }
        "Low" = {
          PropertyPath  = "Severity"
          Operator      = "Equals"
          ExpectedValue = "low"
          PropertyType  = "String"
        }
      }
    },
    "SubAssessments" = {
      EventSource = "SubAssessments"
      RuleSets    = {}
    },
    "Assessments" = {
      EventSource = "Assessments"
      RuleSets = {
        "Type" = {
          PropertyPath  = "type"
          Operator      = "Contains"
          ExpectedValue = "Microsoft.Security/assessments"
          PropertyType  = "String"
        }
      
      }
    },
    "SecureScores" = {
      EventSource = "SecureScores"
      RuleSets    = {}
    },
    "RegulatoryComplianceAssessment" = {
      EventSource = "RegulatoryComplianceAssessment"
      RuleSets    = {}
    }
  }
}


variable "DefenderCwppPlan" {
  type        = map(object({
    enabled = optional(bool, false)
    plan    = optional(string, "Standard")
    subplan = optional(string, null)
    extension = optional(set(string), [])



  }))
  description = "The pricing for CWPP, can be Free or Standard"
  default     = {
    "AI" = {
      enabled = true
      extension = ["AIPromptEvidence"]
    },
    "Api" = {
      enabled = false
      subplan = "P1"
    },
    "AppServices" = {
      enabled = false
    },
    "ContainerRegistry" = {
      enabled = false
    },
    "KeyVaults" = {
      enabled = true
      subplan = "PerKeyVault"
    },
    "KubernetesService" = {
      enabled = false
    },
    "SQLServers" = {
      enabled = false
    },
    "SqlServerVirtualMachines" = {
      enabled = false
    },
    "StorageAccounts" = {
      enabled = true
      subplan = "DefenderForStorageV2"
      extension = ["OnUploadMalwareScanning","SensitiveDataDiscovery"]
    },
    "VirtualMachines" = {
      enabled = true
      subplan = "P1"
      extension = ["MdeDesignatedSubscription",/*"AgentlessVmScanning"/*,"FileIntegrityMonitoring"*/]
    },
    "Arm" = {
      enabled = true
      subplan = "PerSubscription"
    },
    "Dns" = {
      enabled = true
    },
    "OpenSourceRelationalDatabases" = {
      enabled = false
    },
    "Containers" = {
      enabled = true
      extension = ["ContainerRegistriesVulnerabilityAssessments","AgentlessDiscoveryForKubernetes","AgentlessVmScanning","ContainerSensor"]
    },
    "CosmosDB" = {
      enabled = false
    },
  }
}