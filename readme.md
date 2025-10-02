<!-- BEGIN_TF_DOCS -->

# Defender demo

This repo is used to setup a defender for cloud demo environment

## Sample

This terraform configuration leverages mainly the module defendersetup, used to bootstrap defender fo cloud configuration in an azure environment at the subscription level.

 ```hcl



 ```



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=1.1 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.30 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.30 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.3.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AzureADClientID"></a> [AzureADClientID](#input\_AzureADClientID) | The AAD Client ID | `string` | n/a | yes |
| <a name="input_AzureADClientSecret"></a> [AzureADClientSecret](#input\_AzureADClientSecret) | The AAD Application secret | `string` | n/a | yes |
| <a name="input_AzureClientID"></a> [AzureClientID](#input\_AzureClientID) | The application Id, taken from Azure AD app registration | `string` | n/a | yes |
| <a name="input_AzureClientSecret"></a> [AzureClientSecret](#input\_AzureClientSecret) | The Application secret | `string` | n/a | yes |
| <a name="input_AzureRegion"></a> [AzureRegion](#input\_AzureRegion) | The region for the Azure resource | `string` | `"francecentral"` | no |
| <a name="input_AzureSubscriptionID"></a> [AzureSubscriptionID](#input\_AzureSubscriptionID) | The subscription id for the authentication in the provider | `string` | n/a | yes |
| <a name="input_AzureTenantID"></a> [AzureTenantID](#input\_AzureTenantID) | The Azure AD tenant ID | `string` | n/a | yes |
| <a name="input_DefenderPerimeter"></a> [DefenderPerimeter](#input\_DefenderPerimeter) | n/a | <pre>object({<br/>    environment = string<br/>    scope       = string<br/>    scope_index = optional(string, "001")<br/>  })</pre> | <pre>{<br/>  "environment": "lab",<br/>  "scope": "dfc",<br/>  "scope_index": "001"<br/>}</pre> | no |
| <a name="input_RgConfig"></a> [RgConfig](#input\_RgConfig) | n/a | <pre>map(object({<br/>    RgLocation = string<br/><br/><br/>  }))</pre> | <pre>{<br/>  "rsg-acr": {<br/>    "RgLocation": "francecentral"<br/>  },<br/>  "rsg-dns": {<br/>    "RgLocation": "francecentral"<br/>  },<br/>  "rsg-kv": {<br/>    "RgLocation": "francecentral"<br/>  },<br/>  "rsg-monitor": {<br/>    "RgLocation": "francecentral"<br/>  },<br/>  "rsg-security": {<br/>    "RgLocation": "francecentral"<br/>  }<br/>}</pre> | no |
| <a name="input_StaConfig"></a> [StaConfig](#input\_StaConfig) | n/a | <pre>object({<br/>    location              = optional(string, "francecentral")<br/>    account_tier          = optional(string, "Standard")<br/>    access_tier           = optional(string, "Hot")<br/>    account_kind          = optional(string, "StorageV2")<br/>    account_replication   = optional(string, "LRS")<br/>    public_network_access = optional(bool, true)<br/><br/>  })</pre> | <pre>{<br/>  "location": "francecentral"<br/>}</pre> | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_mandatory_tags"></a> [mandatory\_tags](#input\_mandatory\_tags) | n/a | <pre>object({<br/>    data_classification  = optional(string, null)<br/>    operation_commitment = optional(string, null)<br/>    usage                = optional(string, null)<br/>    start_time           = optional(string, null)<br/>    stop_time            = optional(string, null)<br/><br/>  })</pre> | `{}` | no |
| <a name="input_optional_tags"></a> [optional\_tags](#input\_optional\_tags) | n/a | <pre>object({<br/>    owner      = optional(string, "N/A")<br/>    start_date = optional(string, "N/A")<br/><br/>  })</pre> | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.Kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_log_analytics_workspace.LawMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.KvDiagSettings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_resource_group.RGShared](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.STASample](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.StaMonitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.currentclientconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_monitor_diagnostic_categories.keyvaultdiag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_MyIp"></a> [MyIp](#output\_MyIp) | value of my IP address |

## How to update this documentation

In the terraformconfig folder, use the following command.

```bash

terraform-docs --config ./.config/.terraform-doc.yml .

```
<!-- END_TF_DOCS -->