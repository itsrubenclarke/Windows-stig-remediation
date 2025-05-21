<#
.SYNOPSIS
    This script restricts remote calls to the Security Account Manager (SAM) to Administrators only, in compliance with STIG ID WN10-SO-000167.

.DESCRIPTION
    The SAM (Security Account Manager) stores users' credentials. Allowing remote access to it by non-administrative users poses a serious security risk.
    This script enforces the required registry setting to prevent remote RPC access to the SAM except by Administrators.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-SO-000167

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-SO-000167.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:
    
    1. Run:
        Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name RestrictRemoteSAM

    2. Expected output:
        RestrictRemoteSAM : O:BAG:BAD:(A;;RC;;;BA)
#>

# STEP 1: Define registry path and value
$registryPath  = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName     = "RestrictRemoteSAM"
$valueData     = "O:BAG:BAD:(A;;RC;;;BA)"  # DACL that restricts to Administrators only

# STEP 2: Create key path if it doesn't exist
If (-Not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type String | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-SO-000167 remediated. Remote SAM access is now restricted to Administrators only." -ForegroundColor Green
