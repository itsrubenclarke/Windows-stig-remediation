<#
.SYNOPSIS
    Disables Internet Explorer 11 (IE11) as a standalone browser on Windows 10, in compliance with STIG ID WN10-CC-000391.

.DESCRIPTION
    Internet Explorer 11 is no longer supported and must be disabled as a standalone browser on Windows 10 (semi-annual channel). 
    This script updates the registry to ensure that IE11 is disabled, helping to mitigate security risks from legacy browser vulnerabilities.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000391

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise (Semi-Annual Channel)
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000391.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" -Name "DisableStandaloneBrowser"

    2. Expected output:
       DisableStandaloneBrowser : 1
#>

# STEP 1: Define the registry path and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
$name = "DisableStandaloneBrowser"
$value = 1

# STEP 2: Create the path if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Set the required value to disable IE11 as a standalone browser
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

# STEP 4: Confirmation
Write-Host "STIG WN10-CC-000391 remediated. IE11 is now disabled as a standalone browser." -ForegroundColor Green
