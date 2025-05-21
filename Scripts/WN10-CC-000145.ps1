<#
.SYNOPSIS
    Ensures users are prompted for a password when resuming from sleep on battery power,
    in compliance with STIG ID WN10-CC-000145.

.DESCRIPTION
    Authentication must always be enforced when a system resumes from sleep, particularly on battery power.
    This script sets the required registry value to ensure the user is prompted for a password upon wake,
    enhancing physical security in mobile environments.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000145.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51" -Name DCSettingIndex

    2. Expected output:
        DCSettingIndex : 1
#>

# STEP 1: Define registry details
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName    = "DCSettingIndex"
$valueData    = 1

# STEP 2: Ensure the path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Set the required value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000145 remediated. 'Require password on resume (on battery)' is now enforced."
