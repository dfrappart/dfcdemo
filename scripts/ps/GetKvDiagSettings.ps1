<#
.SYNOPSIS
	Get information on Key Vault
.DESCRIPTION
    This script check key vaults on a set of available subscription and export related informations.
.PARAMETER TargetSubscriptions
    cdcdc

.Example


.Example

    
.NOTES
    Author:  david
	Version: 0.1
    Date:    20251119
	Usage:   
#>
<#
param(
    [Parameter(Mandatory = $False)]
    [string] $TargetStaForLog = "stlogaa",
    [Parameter(Mandatory = $False)]
    [string] $RgTargetStaForLog = "rg-pf-prd-eastus-01",
    [Parameter(Mandatory = $False)]
    [string] $StaContainerForLogs = "pslogs",
    [Parameter(Mandatory = $False)]
    [string] $TargetAutomationAccount = "aa-pf-prd-eastus-01",
    [Parameter(Mandatory = $False)]
    [string] $TargetKv = "kv-pf-sec-prd-eastus-01",
    [Parameter(Mandatory = $False)]
    [array] $CustomManagedApplicationList = @("rg-arocluster","appreg-aroauth","AutoRunAs"),
    [Parameter(Mandatory = $False)]
    [int] $PwdDuration = 1,    
    [Parameter(Mandatory = $False)]
    [bool] $UseCustomAppList = $False
)
#>
######################################################################################################
#                                         	Function log
######################################################################################################
function log
{

Param (
	[Parameter(Mandatory=$true,Position=1)]
	[STRING] $string,
	[Parameter(Mandatory=$false,Position=2)]
	[STRING] $color,
    [Parameter(Mandatory=$false,Position=3)]
	[STRING] $datelog
  
    )

#$date = (get-date).tostring('yyyyMMdd')
#$hour = (get-date).tostring('HHmmss')
[string]$logfilename = $datelog + "_renewapppwd.log"
#[string]$path = (Get-Location)
[string]$pathlog = $logfilename

    if (!$Color) 
        {
            [string]$color = "white"
        }
    write-host $string -foregroundcolor $color
    (get-date -format yyyyMMdd_HHmmsstt).tostring()+":"+$string | out-file -Filepath $pathlog -Append   
}

######################################################################################################
#                                         	Main code 
######################################################################################################

#Get date
$dateexecution = (Get-Date -format yyyyMMdd_HHmmsstt).tostring()
#thash table for logging
[hashtable]$logging = @{}
#hash table for return
[hashtable]$return = @{}

log "########################################################################################### " green $dateexecution
log "starting script test.ps1...." green $dateexecution
log "########################################################################################### " green $dateexecution

#error variable clear
$Error.clear()

$SubList = Get-AzSubscription
$KvInfo = @()
$output = @()


foreach($sub in $SubList) {
    Set-AzContext -Subscription $sub.Id |Out-Null
    $logging.CurrentSub = "Current subscription is "+ $sub.Name
    log $logging.CurrentSub green

    $logging.GettingKv = "Getting Key Vaults in "+ $sub.Name+" subscription"
    log $logging.GettingKv green

    $kvList = Search-AzGraph -Query @"
        Resources
        | where type == 'microsoft.keyvault/vaults'
        | project id, name, resourceGroup, subscriptionId, location,properties
"@



    $logging.ParsingKv = "Parsing Key Vaults in "+ $sub.Name+" subscription"
    log $logging.ParsingKv green

    foreach($kv in $KvList) {
        $diag = Get-AzDiagnosticSetting -ResourceId $kv.ResourceId -ErrorAction SilentlyContinue

        [PSCustomObject]@{
            KeyVaultName         = $kv.Name
            ResourceGroup        = $kv.ResourceGroupName
            HasDiagnosticSetting = if ($diag) { "Yes" } else { "No" }
            DiagnosticSettingName = ($diag.Name).ToString()
        
        }
    }

    
}
