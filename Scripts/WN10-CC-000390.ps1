<#
.SYNOPSIS
    Configures the registry to disable third-party suggestions in Windows Spotlight, in compliance with STIG ID WN10-CC-000390.

.DESCRIPTION
    Windows Spotlight may suggest apps and content from third-party publishers, which could expose users to unvetted or unnecessary software. 
    This script ensures that these suggestions are disabled by setting the appropriate registry key under HKEY_CURRENT_USER.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000390

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script in the user context or apply through GPO startup/login scripts for consistent application.
    Example:
    PS C:\> .\WN10-CC-000390.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       Get-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name DisableThirdPartySuggestions

    2. Expected output:
       DisableThirdPartySuggestions : 1
#>

# STEP 1: Define the registry path
$regPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

# STEP 2: Create the path if it doesn’t exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# STEP 3: Set the registry value to disable third-party suggestions
Set-ItemProperty -Path $regPath -Name "DisableThirdPartySuggestions" -Value 1 -Type DWord

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000390 remediated. Third-party suggestions in Windows Spotlight are now disabled."
