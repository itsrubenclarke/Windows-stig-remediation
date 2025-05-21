<#
.SYNOPSIS
    This PowerShell script enables the Windows Defender SmartScreen filter for Microsoft Edge,
    in compliance with STIG ID WN10-CC-000250.

.DESCRIPTION
    The Windows Defender SmartScreen filter helps identify and block potentially malicious websites and downloads.
    Enabling this feature enhances user protection while browsing via Microsoft Edge.
    This script sets the required registry value to ensure SmartScreen is active.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000250

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000250.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name EnabledV9

    2. Expected output:
        EnabledV9 : 1
#>

# STEP 1: Define registry path, value, and data
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$valueName    = "EnabledV9"
$valueData    = 1

# STEP 2: Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Confirmation
Write-Host "STIG WN10-CC-000250 remediated. 'SmartScreen for Microsoft Edge' is now enabled at '$registryPath'." -ForegroundColor Green
