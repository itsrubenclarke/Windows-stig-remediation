<#
.SYNOPSIS
    This PowerShell script disables Solicited Remote Assistance on Windows 10 systems, 
    in alignment with STIG ID WN10-CC-000155.

.DESCRIPTION
    Solicited Remote Assistance enables users to request help that grants interactive access to their session.
    This presents a potential security risk if exploited by unauthorised users.
    This script configures the registry to prevent users from initiating Solicited Remote Assistance requests.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000155

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000155.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name fAllowToGetHelp

    2. Expected output:
        fAllowToGetHelp : 0
#>

# STEP 1: Define the target registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName    = "fAllowToGetHelp"
$valueData    = 0

# STEP 2: Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000155 remediated. 'Solicited Remote Assistance' is now disabled at '$registryPath'." -ForegroundColor Green
