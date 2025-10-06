<!-- BEGIN_TF_DOCS -->

# Defender setup module

This module is used to setup defender for cloud configuration

## Sample

This terraform configuration leverages mainly the module defendersetup, used to bootstrap defender fo cloud configuration in an azure environment at the subscription level.

 ```hcl

module "defendersetup" {
    source = "../modules/defendersetup"

    mandatory_tags = var.mandatory_tags
    optional_tags = var.optional_tags
    DefenderCSPMPricing = "Free"
    

}

 ```



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.44.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.44.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DefenderCSPMExtension"></a> [DefenderCSPMExtension](#input\_DefenderCSPMExtension) | The extensions for CSPM | `set(string)` | <pre>[<br/>  "EntraPermissionsManagement",<br/>  "AgentlessVmScanning"<br/>]</pre> | no |
| <a name="input_DefenderCSPMPricing"></a> [DefenderCSPMPricing](#input\_DefenderCSPMPricing) | The pricing for CSPM, can be Fee or Standard | `string` | `"Standard"` | no |
| <a name="input_DefenderContact"></a> [DefenderContact](#input\_DefenderContact) | An object to define the Defender contact | <pre>object({<br/>    Name  = string<br/>    Email = string<br/><br/>  })</pre> | <pre>{<br/>  "Email": "david@teknews.cloud",<br/>  "Name": "CloudTeam"<br/>}</pre> | no |
| <a name="input_DefenderContinousExportEnabled"></a> [DefenderContinousExportEnabled](#input\_DefenderContinousExportEnabled) | A bool to enable or disable the continuous export | `bool` | `true` | no |
| <a name="input_DefenderContinuousExportMap"></a> [DefenderContinuousExportMap](#input\_DefenderContinuousExportMap) | n/a | <pre>map(object({<br/>    EventSource = string<br/>    RuleSets = optional(map(object({<br/>      PropertyPath  = string<br/>      Operator      = string<br/>      ExpectedValue = string<br/>      PropertyType  = string<br/>    })), {})<br/>  }))</pre> | <pre>{<br/>  "Alerts": {<br/>    "EventSource": "Alerts",<br/>    "RuleSets": {<br/>      "High": {<br/>        "ExpectedValue": "high",<br/>        "Operator": "Equals",<br/>        "PropertyPath": "Severity",<br/>        "PropertyType": "String"<br/>      },<br/>      "Low": {<br/>        "ExpectedValue": "low",<br/>        "Operator": "Equals",<br/>        "PropertyPath": "Severity",<br/>        "PropertyType": "String"<br/>      },<br/>      "Medium": {<br/>        "ExpectedValue": "medium",<br/>        "Operator": "Equals",<br/>        "PropertyPath": "Severity",<br/>        "PropertyType": "String"<br/>      }<br/>    }<br/>  },<br/>  "Assessments": {<br/>    "EventSource": "Assessments",<br/>    "RuleSets": {<br/>      "Type": {<br/>        "ExpectedValue": "Microsoft.Security/assessments",<br/>        "Operator": "Contains",<br/>        "PropertyPath": "type",<br/>        "PropertyType": "String"<br/>      }<br/>    }<br/>  },<br/>  "RegulatoryComplianceAssessment": {<br/>    "EventSource": "RegulatoryComplianceAssessment",<br/>    "RuleSets": {}<br/>  },<br/>  "SecureScores": {<br/>    "EventSource": "SecureScores",<br/>    "RuleSets": {}<br/>  },<br/>  "SubAssessments": {<br/>    "EventSource": "SubAssessments",<br/>    "RuleSets": {}<br/>  }<br/>}</pre> | no |
| <a name="input_DefenderContinuousExportName"></a> [DefenderContinuousExportName](#input\_DefenderContinuousExportName) | The name of the continuous export | `string` | `"ExportToWorkspace"` | no |
| <a name="input_DefenderCwppPlan"></a> [DefenderCwppPlan](#input\_DefenderCwppPlan) | The pricing for CWPP, can be Free or Standard | <pre>map(object({<br/>    enabled = optional(bool, false)<br/>    plan    = optional(string, "Standard")<br/>    subplan = optional(string, null)<br/>    extension = optional(set(string), [])<br/><br/><br/><br/>  }))</pre> | <pre>{<br/>  "AI": {<br/>    "enabled": true,<br/>    "extension": [<br/>      "AIPromptEvidence"<br/>    ]<br/>  },<br/>  "Api": {<br/>    "enabled": false,<br/>    "subplan": "P1"<br/>  },<br/>  "AppServices": {<br/>    "enabled": false<br/>  },<br/>  "Arm": {<br/>    "enabled": true,<br/>    "subplan": "PerSubscription"<br/>  },<br/>  "ContainerRegistry": {<br/>    "enabled": false<br/>  },<br/>  "Containers": {<br/>    "enabled": true,<br/>    "extension": [<br/>      "ContainerRegistriesVulnerabilityAssessments",<br/>      "AgentlessDiscoveryForKubernetes",<br/>      "AgentlessVmScanning",<br/>      "ContainerSensor"<br/>    ]<br/>  },<br/>  "CosmosDB": {<br/>    "enabled": false<br/>  },<br/>  "Dns": {<br/>    "enabled": true<br/>  },<br/>  "KeyVaults": {<br/>    "enabled": true,<br/>    "subplan": "PerKeyVault"<br/>  },<br/>  "KubernetesService": {<br/>    "enabled": false<br/>  },<br/>  "OpenSourceRelationalDatabases": {<br/>    "enabled": false<br/>  },<br/>  "SQLServers": {<br/>    "enabled": false<br/>  },<br/>  "SqlServerVirtualMachines": {<br/>    "enabled": false<br/>  },<br/>  "StorageAccounts": {<br/>    "enabled": true,<br/>    "extension": [<br/>      "OnUploadMalwareScanning",<br/>      "SensitiveDataDiscovery"<br/>    ],<br/>    "subplan": "DefenderForStorageV2"<br/>  },<br/>  "VirtualMachines": {<br/>    "enabled": true,<br/>    "extension": [<br/>      "MdeDesignatedSubscription"<br/>    ],<br/>    "subplan": "P1"<br/>  }<br/>}</pre> | no |
| <a name="input_DefenderLawId"></a> [DefenderLawId](#input\_DefenderLawId) | The Id of the Defender log analytics workspace | `string` | n/a | yes |
| <a name="input_EnableNotifications"></a> [EnableNotifications](#input\_EnableNotifications) | A bool to enable security alert to be send to security contacts | `bool` | `true` | no |
| <a name="input_EnableNotificationsToSubAdmins"></a> [EnableNotificationsToSubAdmins](#input\_EnableNotificationsToSubAdmins) | A bool to enable security alert to be send to subscription admins | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Define the location of the resources | `string` | `"francecentral"` | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | n/a | <pre>object({<br/>    data_classification  = optional(string, null)<br/>    operation_commitment = optional(string, null)<br/>    usage                = optional(string, null)<br/>    start_time           = optional(string, null)<br/>    stop_time            = optional(string, null)<br/><br/>  })</pre> | `{}` | no |
| <a name="input_optional_tags"></a> [optional\_tags](#input\_optional\_tags) | n/a | <pre>object({<br/>    owner      = optional(string, "N/A")<br/>    start_date = optional(string, "N/A")<br/><br/>  })</pre> | `{}` | no |
| <a name="input_perimeter"></a> [perimeter](#input\_perimeter) | n/a | <pre>object({<br/>    environment = string<br/>    scope       = string<br/>    scope_index = optional(string, "001")<br/>  })</pre> | n/a | yes |
| <a name="input_sta_config"></a> [sta\_config](#input\_sta\_config) | n/a | <pre>object({<br/>    location              = optional(string, "francecentral")<br/>    account_tier          = optional(string, "Standard")<br/>    access_tier           = optional(string, "Hot")<br/>    account_kind          = optional(string, "StorageV2")<br/>    account_replication   = optional(string, "LRS")<br/>    public_network_access = optional(bool, true)<br/><br/>  })</pre> | <pre>{<br/>  "location": "francecentral"<br/>}</pre> | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.RGDefender](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_security_center_automation.continuous_export](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_automation) | resource |
| [azurerm_security_center_contact.DefenderContact](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact) | resource |
| [azurerm_security_center_subscription_pricing.DefenderCSPMPricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |
| [azurerm_security_center_subscription_pricing.DefenderCWPPPricing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |
| [azurerm_security_center_workspace.DefenderWorkspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_workspace) | resource |
| [azurerm_client_config.currentclientconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Outputs

No outputs.

## How to update this documentation

In the module folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->