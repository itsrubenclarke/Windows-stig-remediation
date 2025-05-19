<#
.SYNOPSIS
    This PowerShell script disables access to the built-in or attached camera by setting the webcam consent policy to "Deny", in compliance with STIG ID WN10-CC-000007.

.DESCRIPTION
    This script modifies the registry to deny applications access to the camera by updating the Value at:
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam

    Setting this value to "Deny" ensures the system complies with security policy by preventing access to the camera when not explicitly authorised. 
    This is particularly important when the device lacks a physical disconnect method (e.g., cover or hardware disable).

.NOTES
    Author          : Ruben Clarke  
    LinkedIn        : linkedin.com/in/itsrubenclarke/  
    GitHub          : github.com/itsrubenclarke  
    Date Created    : 19-05-2025  
    Last Modified   : 19-05-2025  
    Version         : 1.0  
    STIG-ID         : WN10-CC-000007  

.TESTED ON
    Date(s) Tested  : 19-05-2025  
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise  
    PowerShell Ver. : 5.1+  

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000007.ps1

.VERIFICATION
    To verify the camera setting has been correctly applied:

    Option 1 – Registry Editor:
    1. Press Win + R, type `regedit`, and press Enter
    2. Navigate to:
       HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam
    3. Confirm:
       Value Name: "Value"
       Value Data: "Deny"

    Option 2 – PowerShell:
    Run the following command:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name Value

    Expected output:
        Value : Deny
#>

# STEP 1: Define the registry path and setting
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"
$valueName = "Value"
$valueData = "Deny"

# STEP 2: Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# STEP 3: Apply the registry setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000007 remediated. Camera access is now set to '$valueData'."
