<#
.SYNOPSIS
    Disables the "Always install with elevated privileges" option in Windows Installer to comply with STIG ID WN10-CC-000315.

.DESCRIPTION
    Allowing standard users to install software with elevated privileges increases the risk of privilege escalation.
    This script sets the registry value to disable the AlwaysInstallElevated setting to mitigate this risk.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000315

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000315.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Name AlwaysInstallElevated

    2. Expected output:
       AlwaysInstallElevated : 0
#>

# STEP 1: Define the registry path and setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$name = "AlwaysInstallElevated"
$value = 0

# STEP 2: Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the setting
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000315 remediated. 'Always install with elevated privileges' is now disabled."
