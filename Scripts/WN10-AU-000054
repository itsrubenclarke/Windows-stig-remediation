<#
.SYNOPSIS
    This PowerShell script configures the system to audit Account Lockout failures, in alignment with STIG ID WN10-AU-000054.

.DESCRIPTION
    Account lockout auditing is critical for identifying potentially malicious logon attempts, especially brute-force attacks.
    This script applies the necessary audit policy at the Local Group Policy Object (LGPO) level using `secedit`.

    To ensure the Group Policy Management Console reflects that Logon/Logoff auditing is configured,
    this script also sets a secondary related subcategory ("Logon = Failure") to trigger GUI visibility.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AU-000054

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  :  
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AU-000054.ps1

.VERIFICATION
    Option 1 – Command Line (AuditPol):
    1. Open PowerShell as Administrator
    2. Run:
       AuditPol /get /subcategory:"Account Lockout"
    3. Expected output:
       Account Lockout          Failure

    Option 2 – Export and Inspect INF:
    1. Run:
       secedit /export /cfg "$env:temp\verify_audit.inf"
    2. Then:
       Get-Content "$env:temp\verify_audit.inf" | Select-String "Account Lockout"
    3. Confirm:
       Account Lockout = Failure
    4. Clean up:
       Remove-Item "$env:temp\verify_audit.inf"

    Option 3 – GUI Confirmation:
    1. Open Group Policy Editor (`gpedit.msc`)
    2. Go to:
       Computer Configuration → Windows Settings → Security Settings → Advanced Audit Policy Configuration → System Audit Policies → Logon/Logoff
    3. Ensure:
       “Audit Account Lockout” is configured for “Failure”  
       “Audit Logon” is configured for “Failure”  
       The Logon/Logoff category now displays as “Configured”
#>

# STEP 1: Define the INF file content
# To ensure GUI visibility, we set two subcategories under Logon/Logoff
$infContent = @"
[Version]
signature="\$CHICAGO$"

[AuditPolicy]
Account Lockout = Failure
Logon = Failure
"@

# STEP 2: Save the INF file temporarily
$infPath = "$env:temp\WN10-AU-000054.inf"
$infContent | Out-File -FilePath $infPath -Encoding ASCII -Force

# STEP 3: Apply the audit settings using secedit to write into the LGPO database
secedit /configure /db "$env:windir\security\database\local.sdb" /cfg $infPath /quiet

# STEP 4: Clean up temporary file
Remove-Item $infPath -Force

# STEP 5: Output result to user
Write-Host "STIG WN10-AU-000054 remediated. 'Account Lockout' and 'Logon' failures configured. GUI should now reflect this change."
