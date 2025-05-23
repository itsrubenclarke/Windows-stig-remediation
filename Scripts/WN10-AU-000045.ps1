<#
.SYNOPSIS
    This PowerShell script configures the system to audit Plug and Play (PnP) Activity successes, in alignment with STIG ID WN10-AU-000045.

.DESCRIPTION
    Auditing Plug and Play (PnP) activity provides visibility into the successful connection of external devices such as USB drives.
    This control is critical for investigating suspicious behaviour, enforcing device use policies, and identifying unauthorised physical access.
    
    This script uses the AuditPol command-line utility to enable auditing for "Plug and Play Events" (Success).
    It applies immediately and is visible in both AuditPol and the Group Policy GUI.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.2
    STIG-ID         : WN10-AU-000045

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000045.ps1

.VERIFICATION
   PowerShell:
    1. Run:
       AuditPol /get /subcategory:"Plug and Play Events"
    2. Confirm:
       Plug and Play Events    Success

#>

# STEP 1: Apply the audit setting using AuditPol
# This enables auditing of successful Plug and Play activity
AuditPol /set /subcategory:"Plug and Play Events" /success:enable | Out-Null

# STEP 2: Confirmation message
Write-Host "STIG WN10-AU-000045 remediated. 'Audit PNP Activity' is now configured for Success." -ForegroundColor Green
