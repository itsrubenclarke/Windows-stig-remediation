<#
.SYNOPSIS
    This PowerShell script configures the system to audit Plug and Play (PNP) Activity Successes, in alignment with STIG ID WN10-AU-000045.

.DESCRIPTION
    Plug and Play auditing helps track the successful connection of external devices (e.g. USB drives). 
    This control is vital for maintaining an audit trail that may support forensic analysis and help detect suspicious or unauthorised hardware activity.

    Unlike AuditPol, which applies changes at runtime, this script uses `secedit` to apply the configuration at the Local Group Policy Object (LGPO) level,
    ensuring the setting is persistent and visible in the Group Policy GUI (`gpedit.msc`).

.NOTES
    Author          : Ruben Clarke  
    LinkedIn        : linkedin.com/in/itsrubenclarke/  
    GitHub          : github.com/itsrubenclarke  
    Date Created    : 19-05-2025  
    Last Modified   : 19-05-2025  
    Version         : 1.1  
    STIG-ID         : WN10-AU-000045  

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  :  
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000045.ps1

.VERIFICATION
    To confirm that auditing for Plug and Play Activity Successes is enabled:

    Powershell or Command Line:
    1. Open PowerShell as Administrator
    2. Run:
       AuditPol /get /subcategory:"Plug and Play Events"
    3. Expected output:
       Plug and Play Events          Success

#>

# STEP 1: Define the INF policy content that will enforce Plug and Play auditing
# This section creates a valid secedit policy file that explicitly sets the "Success" flag
$infContent = @"
[Version]
signature="\$CHICAGO$"

[AuditPolicy]
Plug and Play Events = Success
"@

# STEP 2: Write the INF content to a temporary file
# This file will be used by secedit to configure the LGPO database
$infPath = "$env:temp\WN10-AU-000045.inf"
$infContent | Out-File -FilePath $infPath -Encoding ASCII -Force

# STEP 3: Apply the audit policy using secedit
# This writes the setting into the local group policy database (local.sdb), which is visible in the Group Policy GUI
secedit /configure /db "$env:windir\security\database\local.sdb" /cfg $infPath /quiet

# STEP 4: Clean up the temporary INF file
Remove-Item $infPath -Force

# STEP 5: Output a message to confirm remediation
Write-Host "STIG WN10-AU-000045 remediated. 'Audit PNP Activity' is now configured for Success."
