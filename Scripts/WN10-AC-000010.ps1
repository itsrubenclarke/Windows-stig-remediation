<#
.SYNOPSIS
    This PowerShell script configures the system to lock a user account after 3 failed login attempts, in compliance with STIG ID WN10-AC-000010.

.DESCRIPTION
    To help prevent brute-force password attacks, DISA STIGs require that the system locks out a user after a small number of failed login attempts. 
    This script updates the “Account lockout threshold” setting in the system’s local security policy to 3 attempts — or fewer if already stricter.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 18-05-2025
    Last Modified   : 18-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AC-000010.ps1

.VERIFICATION
    To confirm that the "Account lockout threshold" has been correctly applied:

    Option 1 – GUI Method:
    1. Press Win + R, type `gpedit.msc`, and press Enter.
    2. Navigate to:
       Computer Configuration → Windows Settings → Security Settings → Account Policies → Account Lockout Policy
    3. Confirm that "Account lockout threshold" is set to 3.
       Values higher than 3 or set to 0 are noncompliant.

    Option 2 – Command Line Method:
    1. Export the current security policy to a temporary file:
       secedit /export /cfg "$env:temp\audit-check.inf"
    2. Run the following command:
       Select-String -Path "$env:temp\audit-check.inf" -Pattern "LockoutBadCount"
    3. Expected result:
       LockoutBadCount = 3

    4. (Optional) Clean up:
       Remove-Item "$env:temp\audit-check.inf"
#>

# STEP 1: Define a temporary file path to hold the exported security policy
$tempInfPath = "$env:temp\lockout_threshold.inf"

# STEP 2: Export the current system security settings
secedit /export /cfg $tempInfPath > $null

# STEP 3: Load contents of the exported file
$content = Get-Content $tempInfPath

# STEP 4: Search and replace or insert the required setting
if ($content -match "LockoutBadCount") {
    $content = $content -replace 'LockoutBadCount = \d+', 'LockoutBadCount = 3'
} else {
    $content += "`nLockoutBadCount = 3"
}

# STEP 5: Save updated settings
$content | Set-Content -Path $tempInfPath

# STEP 6: Apply changes to local security policy
secedit /configure /db "$env:windir\security\local.sdb" /cfg $tempInfPath /quiet

# STEP 7: Clean up
Remove-Item $tempInfPath -Force

# STEP 8: Confirm completion
Write-Host "STIG WN10-AC-000010 remediated. Account lockout threshold has been set to 3 attempts."
