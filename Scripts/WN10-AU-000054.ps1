<#
.SYNOPSIS
    This PowerShell script enables auditing for Account Lockout failures, in alignment with STIG ID WN10-AU-000054.

.DESCRIPTION
    Enabling auditing for account lockout events provides visibility into potential brute-force or unauthorised access attempts.
    This script uses the AuditPol utility to configure the "Account Lockout" subcategory for "Failure" events.
    The change is immediate, persists until overridden by GPO, and is visible in both AuditPol and Group Policy Editor.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.2
    STIG-ID         : WN10-AU-000054

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000054.ps1

.VERIFICATION
    PowerShell:
    1. Run:
       AuditPol /get /subcategory:"Account Lockout"
    2. Confirm:
       Account Lockout    Failure

#>

# STEP 1: Apply the audit setting using AuditPol
# This sets auditing for account lockout events to "Failure"
AuditPol /set /subcategory:"Account Lockout" /failure:enable | Out-Null

# STEP 2: Confirm remediation
Write-Host "STIG WN10-AU-000054 remediated. 'Audit Account Lockout' is now configured for Failure."
