 <#
.SYNOPSIS
    Enables auditing for Account Logon → Credential Validation (Failure), in compliance with STIG ID WN10-AU-000005.

.DESCRIPTION
    This script ensures that auditing is enabled for failed credential validation attempts, which helps identify logon issues and potential unauthorized access attempts.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 21-05-2025
    Last Modified   : 21-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AU-000005

.TESTED ON
    Date(s) Tested  : 21-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000005.ps1

.VERIFICATION
    To verify via PowerShell that the setting has been correctly applied:

    1. Run:
       AuditPol /get /subcategory:"Credential Validation"

    2. Expected output:
       Account Logon >> Credential Validation  Failure
#>

# Enable auditing for Credential Validation (Failure only)
AuditPol /set /subcategory:"Credential Validation" /success:disable /failure:enable

Write-Host "STIG WN10-AU-000005 remediated. 'Credential Validation' is now audited on failure."
 
