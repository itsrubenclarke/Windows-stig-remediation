<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB), in compliance with STIG ID WN10-AU-000500.

.DESCRIPTION
    The Windows Application event log captures events written by applications and system services.  
    If the log size is too small, important entries may be overwritten before they can be reviewed or exported,  
    which presents a risk to auditability and incident response readiness.

    This script modifies the system’s registry to set the maximum size of the Application event log to 32768 KB (32 MB) or greater.  
    The change aligns with DISA STIG guidance and ensures sufficient log retention for compliance and investigation purposes.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 18-05-2025
    Last Modified   : 18-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell ISE or terminal:
    Example:
    PS C:\> .\WN10-AU-000500.ps1

.VERIFICATION
    To verify that the maximum size of the Application event log has been applied correctly:

    Option 1 – GUI Method:
    1. Open Event Viewer (`eventvwr.msc`)
    2. Navigate to: Windows Logs → Application → Right-click → Properties
    3. Confirm that "Maximum log size (KB)" is set to at least 32768

    Option 2 – Registry Check:
    1. Open PowerShell and run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application" -Name MaxSize
    2. Confirm output:
       MaxSize : 32768
#>

# STEP 1: Define the registry path and value to be enforced.
# This registry key controls the size limit for the Application event log.
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$valueData = 32768  # Value is in KB (32 MB)

# STEP 2: Check if the registry path exists. If not, create it. Suppress output.
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Set the registry value to 32768 KB. Suppress output.
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Display a single-line confirmation message.
Write-Host "STIG WN10-AU-000500 remediated. Registry value '$valueName' set to '$valueData' at '$registryPath'." -ForegroundColor Green
