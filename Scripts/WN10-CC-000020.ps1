<#
.SYNOPSIS
    Disables IPv6 source routing to highest protection level in alignment with STIG ID WN10-CC-000020.

.DESCRIPTION
    This script enforces the highest protection level for IPv6 source routing by setting the registry value
    `DisableIPSourceRouting` to `2`. This protects against IP packet spoofing and enforces secure network behaviour.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000020

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000020.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name DisableIPSourceRouting

    2. Expected output:
       DisableIPSourceRouting : 2
#>

# STEP 1: Define the registry path and value
$regPath  = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$regName  = "DisableIPSourceRouting"
$regValue = 2

# STEP 2: Apply the setting
New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWORD -Force | Out-Null

# STEP 3: Output confirmation
Write-Host "STIG WN10-CC-000020 remediated. IPv6 source routing is now set to 'Highest Protection' (value 2)."
