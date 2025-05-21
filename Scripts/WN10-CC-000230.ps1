<#
.SYNOPSIS
    This PowerShell script prevents users from bypassing Windows Defender SmartScreen warnings in Microsoft Edge,
    in alignment with STIG ID WN10-CC-000230.

.DESCRIPTION
    Windows Defender SmartScreen provides warnings and protection against potentially malicious websites and downloads.
    If users are permitted to ignore SmartScreen warnings, they may still access harmful content.
    This script configures the system to disallow such overrides, enhancing security and aligning with DISA STIG compliance.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000230

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000230.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name PreventOverride

    2. Expected output:
        PreventOverride : 1
#>

# STEP 1: Define registry target
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$valueName    = "PreventOverride"
$valueData    = 1

# STEP 2: Create key path if not present
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the required setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000230 remediated. 'PreventOverride' set to '$valueData' at '$registryPath'." -ForegroundColor Green
