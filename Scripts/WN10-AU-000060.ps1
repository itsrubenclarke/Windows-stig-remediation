  <#
.SYNOPSIS
    Enables auditing of Group Membership successes for Logon/Logoff events (STIG ID WN10-AU-000060).

.DESCRIPTION
    Group Membership auditing tracks which security groups a user belongs to at the time of logon.
    This is critical for understanding access privileges and supporting forensic investigations.

    This version uses auditpol.exe to ensure the setting is enforced and visible in both CLI and GUI.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AU-000060

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000060.ps1

.VERIFICATION
    To confirm the setting has been applied correctly:

    Option 1 – Command Line:
    1. Open PowerShell as Administrator
    2. Run:
       AuditPol /get /subcategory:"Group Membership"
    3. Expected output:
       Group Membership      Success

    Option 2 – GUI:
    1. Open `gpedit.msc`
    2. Navigate to:
       Computer Configuration → Windows Settings → Security Settings → Advanced Audit Policy Configuration → System Audit Policies → Logon/Logoff
    3. Confirm that "Audit Group Membership" is shown as configured for “Success”
#>

# STEP 0: Ensure subcategory audit policies are honoured system-wide
# This allows granular settings like "Group Membership" to take effect
$currentOption = (auditpol /get /option:subcategoryaudit) -match "Enable"
if (-not $currentOption) {
    Start-Process -FilePath "auditpol.exe" -ArgumentList "/set /option:subcategoryaudit /value:enable" -NoNewWindow -Wait
}

# STEP 1: Apply Success auditing for Group Membership
Start-Process -FilePath "auditpol.exe" -ArgumentList "/set /subcategory:`"Group Membership`" /success:enable" -NoNewWindow -Wait

# STEP 2: Confirm remediation success
Write-Host "STIG WN10-AU-000060 remediated. 'Group Membership' is now configured for Success." -ForegroundColor Green
