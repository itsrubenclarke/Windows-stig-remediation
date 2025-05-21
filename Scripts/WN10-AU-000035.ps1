<#
.SYNOPSIS
    Configures the system to audit User Account Management failures in alignment with STIG ID WN10-AU-000035.

.DESCRIPTION
    This script enables auditing for "User Account Management" failures to provide visibility into failed attempts
    to manage user accounts, such as unsuccessful creation, deletion, or modification events. This supports
    accountability, traceability, and early threat detection.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000035

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000035.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       AuditPol /get /subcategory:"User Account Management"

    2. Expected output:
       User Account Management    Failure
#>

# STEP 1: Apply the audit setting using AuditPol
AuditPol /set /subcategory:"User Account Management" /failure:enable | Out-Null

# STEP 2: Output confirmation
Write-Host "STIG WN10-AU-000035 remediated. 'User Account Management' auditing is now enabled for failures." -ForegroundColor Green
