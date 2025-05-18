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
#>

# STEP 1: Define a temporary file path to hold the current security policy
$tempInfPath = "$env:temp\lockout_threshold.inf"

# STEP 2: Export the current system security settings to a file
# This gives us a baseline to edit and apply new settings
secedit /export /cfg $tempInfPath > $null

# STEP 3: Read the content of the exported file
# This allows us to search for and modify the required setting
$content = Get-Content $tempInfPath

# STEP 4: Check if "LockoutBadCount" (threshold) exists
# If it does, update the value to 3
# If it doesn’t, add the setting to the end of the file
if ($content -match "LockoutBadCount") {
    $content = $content -replace 'LockoutBadCount = \d+', 'LockoutBadCount = 3'
} else {
    $content += "`nLockoutBadCount = 3"
}

# STEP 5: Save the updated content back to the same file
$content | Set-Content -Path $tempInfPath

# STEP 6: Apply the new setting to the local system using secedit
# This enforces the lockout threshold policy without using the Group Policy GUI
secedit /configure /db "$env:windir\security\local.sdb" /cfg $tempInfPath /quiet

# STEP 7: Clean up the temporary file
Remove-Item $tempInfPath -Force

# STEP 8: Output confirmation
Write-Host "STIG WN10-AC-000010 remediated. Account lockout threshold has been set to 3 attempts."
 
