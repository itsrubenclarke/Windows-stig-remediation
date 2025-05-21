<#
.SYNOPSIS
    This PowerShell script disables the storage of RunAs credentials for the Windows Remote Management (WinRM) service, in compliance with STIG ID WN10-CC-000355.

.DESCRIPTION
    Storing administrative credentials with the WinRM service introduces the risk of credential theft or misuse.
    DISA STIG requires the registry to be configured such that the WinRM service is not allowed to store RunAs credentials.
    
    This script creates or updates the necessary registry key to disallow storage of RunAs credentials by setting:
    HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\DisableRunAs = 1

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000355

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000355.ps1

.VERIFICATION
    Option 1 – Registry Check:
    1. Open PowerShell and run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Name DisableRunAs
    2. Confirm output:
       DisableRunAs : 1

#>

# STEP 1: Define the registry location and expected setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName    = "DisableRunAs"
$valueData    = 1

# STEP 2: Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the required registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output confirmation 
Write-Host "STIG WN10-CC-000355 remediated. 'DisableRunAs' set to 1 at $registryPath." -ForegroundColor Green
