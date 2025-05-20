<#
.SYNOPSIS
    This PowerShell script configures Windows 10 to audit failures for "Other Object Access Events", aligning with STIG ID WN10-AU-000084.

.DESCRIPTION
    Auditing Other Object Access Events captures failures related to managing system-level objects such as COM+ components and task scheduler jobs.
    This logging supports detection of unusual or unauthorised access patterns, aiding forensic investigation and incident response.
    The script uses AuditPol to enforce the setting and verify that the configuration was applied correctly.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AU-000084

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000084.ps1

.VERIFICATION
    To confirm that the policy was applied, run the following PowerShell:
    
    1. Run:
        AuditPol /get /subcategory:"Other Object Access Events"

    2. Expected Output:
        Other Object Access Events    Failure
#>

# STEP 1: Apply the audit setting using AuditPol
AuditPol /set /subcategory:"Other Object Access Events" /failure:enable | Out-Null

# STEP 2: Output confirmation
Write-Host "STIG WN10-AU-000084 remediated. 'Other Object Access Events' auditing is now enabled for Failure."
