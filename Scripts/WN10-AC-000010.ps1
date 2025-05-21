<#
.SYNOPSIS
    Configures the system to trigger an account lockout after 3 failed login attempts, per STIG ID WN10-AC-000010.

.DESCRIPTION
    To reduce the risk of brute-force password attacks, DISA STIGs require systems to lock accounts after a small number of failed login attempts.
    This script configures the "Account lockout threshold" setting to 3 attempts using Windows security policy tools.
    The change is written to the local security database (local.sdb) and is persistent across reboots.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AC-000010.ps1

.VERIFICATION
    GUI:
    1. Run `gpedit.msc`
    2. Go to:
       Computer Configuration → Windows Settings → Security Settings → Account Policies → Account Lockout Policy
    3. Confirm:
       “Account lockout threshold” is set to 3 or fewer

#>

# STEP 1: Define temp file to hold the security policy snapshot
$tempInfPath = "$env:temp\lockout_threshold.inf"

# STEP 2: Export current policy settings
secedit /export /cfg $tempInfPath > $null

# STEP 3: Read file content
$content = Get-Content $tempInfPath

# STEP 4: Search and update or append the required line
if ($content -match "LockoutBadCount") {
    $content = $content -replace 'LockoutBadCount = \d+', 'LockoutBadCount = 3'
} else {
    $content += "`nLockoutBadCount = 3"
}

# STEP 5: Save updated content back to the file
$content | Set-Content -Path $tempInfPath

# STEP 6: Apply changes to local security policy database
secedit /configure /db "$env:windir\security\local.sdb" /cfg $tempInfPath /quiet

# STEP 7: Clean up temp file
Remove-Item $tempInfPath -Force

# STEP 8: Notify completion
Write-Host "STIG WN10-AC-000010 remediated. Account lockout threshold set to 3." -ForegroundColor Green
