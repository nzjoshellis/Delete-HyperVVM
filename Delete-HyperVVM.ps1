################################################################
# SCRIPT: Delete-HyperVVM.ps1
# AUTHOR: Josh Ellis - Josh@JoshEllis.NZ
# Website: JoshEllis.NZ
# VERSION: 1.0
# DATE: 08/02/2016
# DESCRIPTION: Deletes a Hyper-V Virtual Machine
################################################################


[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$Name
     )

#Variables
$ErrorActionPreference = "SilentlyContinue"
$CheckVM = Get-VM -name $Name

#Validate VM Exists
if (!$CheckVM) 
    {Write-Host "[ERROR] No VM named $Name exists" -ForegroundColor Red; Exit }

#Get VM Path to remove Disks
$VMPath = Get-VM -Name $Name | Select -ExpandProperty Path

#Stop VM, Remove VM & Delete Files  
Get-VM -Name $Name | Stop-VM -Force | Out-Null
Get-VM -Name $Name | Remove-VM -Force
Remove-Item -Path $VMPath -Recurse -Force

