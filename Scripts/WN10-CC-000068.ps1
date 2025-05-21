<#
.SYNOPSIS
    This script configures the system to allow delegation of non-exportable credentials to remote hosts, in compliance with STIG ID WN10-CC-000068.

.DESCRIPTION
    Enabling the "AllowProtectedCreds" setting helps protect user credentials by enforcing Restricted Admin mode or Remote Credential Guard.
    These security mechanisms prevent exportable credential theft during remote sessions.

    This script sets the required registry key to enable this protection and ensure compliance.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000068

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000068.ps1

.VERIFICATION
   To verify via PowerShell that the setting has been correctly applied:
    
    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name AllowProtectedCreds

    2. Expected output:
        AllowProtectedCreds : 1
#>

# STEP 1: Define registry path and values
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$valueName    = "AllowProtectedCreds"
$valueData    = 1

# STEP 2: Create registry path if it doesn't exist
If (-Not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the registry setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output success message
Write-Host "STIG WN10-CC-000068 remediated. 'AllowProtectedCreds' set to 1 (enabled)." -ForegroundColor Green
