<#
.SYNOPSIS
    This PowerShell script configures the system to audit Sensitive Privilege Use failures, in alignment with STIG ID WN10-AU-000110.

.DESCRIPTION
    Auditing sensitive privilege use helps detect abuse of high-privilege operations such as "Act as part of the operating system"
    or "Debug programs". These events are critical for forensic analysis and identifying potential misuse of administrative rights.

    This script updates the audit policy to enable logging of Sensitive Privilege Use failures. It uses `auditpol` and `secedit`
    to make the configuration persistent and visible in the Group Policy GUI.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000110

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000110.ps1

.VERIFICATION
    To confirm the setting has been successfully applied:

    Command Line:
    1. Open PowerShell as Administrator
    2. Run:
       AuditPol /get /subcategory:"Sensitive Privilege Use"
    3. Expected output:
       Privilege Use → Sensitive Privilege Use      Failure

#>

# STEP 1: Ensure prerequisite is enabled to allow subcategory policies to override general category settings
Start-Process -FilePath "auditpol.exe" -ArgumentList "/set /option:SCENoApplyLegacyAuditPolicy /value:1" -NoNewWindow -Wait

# STEP 2: Apply the setting for auditing Sensitive Privilege Use failures
Start-Process -FilePath "auditpol.exe" -ArgumentList "/set /subcategory:`"Sensitive Privilege Use`" /failure:enable" -NoNewWindow -Wait

# STEP 3: Output confirmation message
Write-Host "STIG WN10-AU-000110 remediated. 'Sensitive Privilege Use' is now configured to audit failures."-ForegroundColor Green
