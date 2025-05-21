<#
.SYNOPSIS
    This PowerShell script disables the lock screen slideshow feature, in alignment with STIG ID WN10-CC-000010.

.DESCRIPTION
    Slideshow features on the lock screen may expose sensitive or unauthorised information to individuals in proximity to a logged-in device.
    To mitigate this risk, DISA STIG recommends preventing lock screen slideshows by enabling the Group Policy setting:
    "Prevent enabling lock screen slide show."

    This script modifies the system registry to set the required policy key and value to prevent slideshow functionality on the lock screen.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 19-05-2025
    Last Modified   : 19-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 19-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000010.ps1

.VERIFICATION
    Option 1 – Registry Check:
    1. Open PowerShell and run:
       Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name NoLockScreenSlideshow
    2. Confirm output:
       NoLockScreenSlideshow : 1
#>

# STEP 1: Define the registry path and policy setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$valueName = "NoLockScreenSlideshow"
$valueData = 1

# STEP 2: Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the registry policy setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000010 remediated. Lock screen slideshow disabled by setting '$valueName' to '$valueData' at '$registryPath'." -ForegroundColor Green
