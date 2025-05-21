<#
.SYNOPSIS
    This PowerShell script ensures that the System event log maximum size is at least 32768 KB (32 MB), in compliance with STIG ID WN10-AU-000510.

.DESCRIPTION
    The Windows System event log is used to capture system events written by the operating system.
    If the log size is too small, critical events may be overwritten before they can be reviewed or exported,
    which presents a risk to auditability and incident response readiness.

    This script modifies the system’s registry to set the System event log maximum size to 32768 KB (32 MB) or greater.
    The change aligns with DISA STIG guidance and ensures sufficient log retention for compliance and investigation purposes.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000510.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System" -Name MaxSize

    2. Expected output:
        MaxSize : 32768
#>

# STEP 1: Define registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$valueData = 32768  # in KB (32 MB)

# STEP 2: Create registry key path if it doesn't exist (suppress output)
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the registry value (suppress output)
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Display confirmation only
Write-Host "STIG WN10-AU-000510 remediated. Registry value '$valueName' set to '$valueData' at '$registryPath'." -ForegroundColor Green
