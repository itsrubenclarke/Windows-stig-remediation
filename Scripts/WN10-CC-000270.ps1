<#
.SYNOPSIS
    Prevents saving passwords in the Remote Desktop Client, in compliance with STIG ID WN10-CC-000270.

.DESCRIPTION
    Saving passwords in the Remote Desktop Client may expose user credentials to unauthorised users.
    This script sets the required registry key to disallow password saving in Remote Desktop Connection.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000270

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000270.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name DisablePasswordSaving

    2. Expected output:
       DisablePasswordSaving : 1
#>

# STEP 1: Define the registry path and name
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$name = "DisablePasswordSaving"
$value = 1

# STEP 2: Ensure the path exists and apply the setting
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

# STEP 3: Output confirmation
Write-Host "STIG WN10-CC-000270 remediated. Password saving in the Remote Desktop Client is now disabled." -ForegroundColor Green
