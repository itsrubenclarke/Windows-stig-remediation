 <#
.SYNOPSIS
    Enables auditing for Object Access – Other Object Access Events (Success) in compliance with STIG ID WN10-AU-000083.

.DESCRIPTION
    This script configures the local audit policy to track successful events under the "Other Object Access Events" category. 
    Auditing this category helps detect changes and access to COM+ objects and task scheduler jobs, contributing to 
    security monitoring and incident response.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AU-000083

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000083.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       AuditPol /get /subcategory:"Other Object Access Events"

    2. Expected output:
       Other Object Access Events        Success
#>

# STEP 1: Enable success auditing for 'Other Object Access Events'
AuditPol /set /subcategory:"Other Object Access Events" /success:enable /failure:disable

# STEP 2: Confirmation output
Write-Host "STIG WN10-AU-000083 remediated. 'Other Object Access Events' is now audited for Success." -ForegroundColor Green
 
