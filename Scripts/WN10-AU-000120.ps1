<#
.SYNOPSIS
    This PowerShell script configures the system to audit System - IPSec Driver failures, 
    in compliance with STIG ID WN10-AU-000120.

.DESCRIPTION
    Auditing IPSec Driver failures helps capture events such as dropped IPsec packets, 
    which are useful for identifying configuration issues, traffic rejection, or unauthorized system activity.

    This script enables auditing for the IPSec Driver failure subcategory using `auditpol`, 
    ensuring visibility in both the command line (`AuditPol`) and Group Policy GUI (`gpedit.msc`). 
    The prerequisite enforcement of subcategory-based audit policy is included.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000120

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000120.ps1

.VERIFICATION
    To confirm that auditing for IPSec Driver failures is enabled:

    Option 1 – Command Line:
    1. Open PowerShell as Administrator
    2. Run:
       AuditPol /get /subcategory:"IPSec Driver"
    3. Expected output:
       IPSec Driver         Failure

    Option 2 – GUI (Group Policy):
    1. Open the Group Policy Editor (`gpedit.msc`)
    2. Navigate to:
       Computer Configuration → Windows Settings → Security Settings → 
       Advanced Audit Policy Configuration → System Audit Policies → System
    3. Confirm:
       “Audit IPSec Driver” is shown as configured for “Failure”
#>

# STEP 1: Ensure subcategory auditing is enforced (only needs to be done once)
Start-Process -FilePath "auditpol.exe" `
    -ArgumentList "/set /option:subcategoryaudit /value:enable" `
    -NoNewWindow -Wait

# STEP 2: Configure 'Audit IPSec Driver' to capture failure events
Start-Process -FilePath "auditpol.exe" `
    -ArgumentList '/set /subcategory:"IPSec Driver" /failure:enable' `
    -NoNewWindow -Wait

# STEP 3: Output confirmation
Write-Host "STIG WN10-AU-000120 remediated. 'Audit IPSec Driver' is now configured for Failure."
