<#
.SYNOPSIS
    Enables auditing for Other Policy Change Events (Failure only) in compliance with STIG ID WN10-AU-000555.

.DESCRIPTION
    This script configures the local audit policy to track failure events under the "Other Policy Change Events" category.
    Monitoring this helps detect unauthorized changes to EFS DRA settings, Windows Filtering Platform rules, and Group Policy updates.

.NOTES
    Author       : Ruben Clarke
    LinkedIn     : linkedin.com/in/itsrubenclarke/
    GitHub       : github.com/itsrubenclarke
    Date Created : 21-05-2025
    Last Modified: 21-05-2025
    Version      : 1.0
    STIG-ID      : WN10-AU-000555

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000555.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       AuditPol /get /subcategory:"Other Policy Change Events"

    2. Expected output:
       Policy Change >> Other Policy Change Events   Failure
#>

# Remediation: Enable only Failure auditing, disable Success if active
AuditPol /set /subcategory:"Other Policy Change Events" /success:disable /failure:enable

# Result Message
Write-Host "STIG WN10-AU-000555 remediated. 'Other Policy Change Events' is now audited on failure only." -ForegroundColor Green
