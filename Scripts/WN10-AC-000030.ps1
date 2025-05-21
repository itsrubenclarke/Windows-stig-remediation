<#
.SYNOPSIS
    This PowerShell script enforces a minimum password age of at least 1 day,
    in compliance with STIG ID WN10-AC-000030.

.DESCRIPTION
    Setting a minimum password age prevents users from changing passwords in rapid succession,
    which would otherwise allow them to bypass password history enforcement. This policy
    ensures meaningful intervals between password changes and supports secure credential hygiene.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AC-000030.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       net accounts

    2. Expected output should include:
       Minimum password age (days): 1 
#>

# STEP 1: Enforce minimum password age of 1 day
net accounts /minpwage:1

# STEP 2: Output confirmation
Write-Host "STIG WN10-AC-000030 remediated. Minimum password age is now set to at least 1 day." -ForegroundColor Green
