<#
.SYNOPSIS
    This PowerShell script enforces a minimum PIN length of six characters or more, 
    in compliance with STIG ID WN10-CC-000260.

.DESCRIPTION
    Longer PIN lengths strengthen authentication by increasing the number of possible 
    combinations, reducing the risk of brute-force attacks. This script ensures that 
    systems configured for Windows Hello for Business or Microsoft Passport enforce a 
    minimum PIN length of 6 via registry policy.

    The registry value is applied at:
    HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000260

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000260.ps1

.VERIFICATION
    To confirm that the minimum PIN length is correctly enforced:

PowerShell:
    1. Run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity" -Name MinimumPINLength
    2. Expected output:
       MinimumPINLength : 6

#>

# STEP 1: Define registry path
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity"

# STEP 2: Ensure the path exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# STEP 3: Set the minimum PIN length to 6
Set-ItemProperty -Path $RegPath -Name MinimumPINLength -Value 6 -Type DWord

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000260 remediated. MinimumPINLength is now set to 6." -ForegroundColor Green
