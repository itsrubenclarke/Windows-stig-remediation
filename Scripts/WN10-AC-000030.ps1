<#
.SYNOPSIS
    Enforces a minimum password age of at least 1 day, in compliance with STIG ID WN10-AC-000030.

.DESCRIPTION
    This script sets the system policy to prevent users from changing passwords in immediate succession.
    Requiring a minimum password age enforces meaningful intervals between password changes.

.NOTES
    Author       : Ruben Clarke
    LinkedIn     : linkedin.com/in/itsrubenclarke/
    GitHub       : github.com/itsrubenclarke
    Date Created : 21-05-2025
    Last Modified: 21-05-2025
    Version      : 1.0
    STIG-ID      : WN10-AC-000030

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

# Remediation: Set Minimum Password Age to 1 day
net accounts /minpwage:1

# Result Message
Write-Host "STIG WN10-AC-000030 remediated. Minimum password age is now set to at least 1 day." -ForegroundColor Green
