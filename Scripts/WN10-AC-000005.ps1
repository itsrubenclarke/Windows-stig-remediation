<#
.SYNOPSIS
    Configures the system to enforce a 15-minute lockout period after failed login attempts, per STIG ID WN10-AC-000005.

.DESCRIPTION
    This script modifies the "Account lockout duration" policy to ensure that, once an account is locked,
    it remains inaccessible for at least 15 minutes. This helps slow down brute-force password attacks.
    The policy is applied using secedit and is written to the local security database (local.sdb).

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.1
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AC-000005.ps1

.VERIFICATION
    GUI:
    1. Run `gpedit.msc`
    2. Go to:
       Computer Configuration → Windows Settings → Security Settings → Account Policies → Account Lockout Policy
    3. Confirm:
       “Account lockout duration” is set to 15 or greater

#>

# STEP 1: Define temporary file path
$tempInfPath = "$env:temp\lockout_duration.inf"

# STEP 2: Export current policy configuration
secedit /export /cfg $tempInfPath > $null

# STEP 3: Load content into memory
$content = Get-Content $tempInfPath

# STEP 4: Modify or append LockoutDuration setting
if ($content -match "LockoutDuration") {
    $content = $content -replace 'LockoutDuration = \d+', 'LockoutDuration = 15'
} else {
    $content += "`nLockoutDuration = 15"
}

# STEP 5: Save the updated policy
$content | Set-Content -Path $tempInfPath

# STEP 6: Apply the new policy using secedit
secedit /configure /db "$env:windir\security\local.sdb" /cfg $tempInfPath /quiet

# STEP 7: Delete temporary file
Remove-Item $tempInfPath -Force

# STEP 8: Confirmation message
Write-Host "STIG WN10-AC-000005 remediated. Account lockout duration set to 15 minutes." -ForegroundColor Green
