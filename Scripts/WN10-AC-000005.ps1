<#
.SYNOPSIS
    This PowerShell script configures the Account Lockout Duration to 15 minutes, in alignment with STIG ID WN10-AC-000005.

.DESCRIPTION
    When users fail to log in multiple times, this setting locks their account for a set duration. According to the STIG requirement, the system must be configured to lock the account for at least 15 minutes after failed attempts.
    This script automatically makes that change using Windows built-in policy tools.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 18-05-2025
    Last Modified   : 18-05-2025
    Version         : 1.0
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-AC-000005.ps1
#>

# STEP 1: Define a temporary file path where we will export the current security settings.
# Think of this as creating a copy of the system's current lockout settings.
$tempInfPath = "$env:temp\account_lockout.inf"

# STEP 2: Export the system's current security policy settings into that temporary file.
# This includes all local policy settings like account lockout, password rules, etc.
secedit /export /cfg $tempInfPath > $null

# STEP 3: Read the contents of the exported file into memory so we can look for the specific setting we want to change.
$content = Get-Content $tempInfPath

# STEP 4: Check if "LockoutDuration" already exists in the file.
# If it does, replace its value with 15. If not, add the setting to the end of the file.
if ($content -match "LockoutDuration") {
    $content = $content -replace 'LockoutDuration = \d+', 'LockoutDuration = 15'
} else {
    $content += "`nLockoutDuration = 15"
}

# STEP 5: Save the updated content back to the same file.
# This updates the security configuration with our new setting.
$content | Set-Content -Path $tempInfPath

# STEP 6: Apply the updated policy to the system.
# This pushes the changes into the system's local security policy database.
secedit /configure /db "$env:windir\security\local.sdb" /cfg $tempInfPath /quiet

# STEP 7: Delete the temporary file to keep the system clean.
Remove-Item $tempInfPath -Force

# STEP 8: Confirm the setting has been applied.
Write-Host "STIG WN10-AC-000005 remediated. Account lockout duration has been set to 15 minutes."
