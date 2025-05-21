<#
.SYNOPSIS
    This PowerShell script configures the system to audit credential validation successes,
    in compliance with STIG ID WN10-AU-000010.

.DESCRIPTION
    Credential validation auditing logs successful attempts to validate credentials during account logon.
    This is critical for detecting unauthorised access and understanding successful authentication activity.

    This script applies the required audit policy via the AuditPol utility for:
    "Account Logon >> Credential Validation" set to Success.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000010

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000010.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
        AuditPol /get /subcategory:"Credential Validation"

    2. Expected output:
        Credential Validation    Success
#>

# STEP 1: Apply the audit setting for Credential Validation Success
AuditPol /set /subcategory:"Credential Validation" /success:enable | Out-Null

# STEP 2: Output confirmation
Write-Host "STIG WN10-AU-000010 remediated. 'Credential Validation' is now configured for Success." -ForegroundColor Green
