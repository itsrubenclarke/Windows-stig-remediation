<#
.SYNOPSIS
    Disables Internet Connection Sharing by configuring the registry, in alignment with STIG ID WN10-CC-000044.

.DESCRIPTION
    Internet Connection Sharing allows one device to share its internet connection with others, which could be abused 
    by malicious actors to bridge insecure networks. This script ensures the UI for enabling ICS is hidden, reducing 
    the risk of accidental or intentional hotspot creation.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000044

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000044.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections" -Name NC_ShowSharedAccessUI

    2. Expected output:
       NC_ShowSharedAccessUI : 0
#>

# STEP 1: Create the registry path if it doesn't exist
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# STEP 2: Set the registry value to disable Internet Connection Sharing UI
Set-ItemProperty -Path $regPath -Name "NC_ShowSharedAccessUI" -Value 0 -Type DWord

# STEP 3: Output confirmation
Write-Host "STIG WN10-CC-000044 remediated. Internet Connection Sharing UI has been disabled." -ForegroundColor Green
