<#
.SYNOPSIS
    This script enables PowerShell Transcription on Windows 10, in compliance with STIG ID WN10-CC-000327.

.DESCRIPTION
    PowerShell Transcription records detailed logs of all PowerShell commands and output during execution.
    This setting helps support incident investigation, forensic review, and tracking of suspicious or unauthorized script activity.
    This script configures the registry key to enable transcription, aligning with DISA STIG recommendations.

.NOTES
    Author          : Ruben Clarke
    LinkedIn        : linkedin.com/in/itsrubenclarke/
    GitHub          : github.com/itsrubenclarke
    Date Created    : 20-05-2025
    Last Modified   : 20-05-2025
    Version         : 1.0
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 20-05-2025
    Tested By       : Ruben Clarke
    Systems Tested  : Windows 10 Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as an administrator from PowerShell:
    Example:
    PS C:\> .\WN10-CC-000327.ps1

.VERIFICATION
    To verify the setting via PowerShell:
    
    1. Run:
        Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Name EnableTranscripting

    2. Expected output:
        EnableTranscripting : 1
#>

# STEP 1: Define the registry path and value
$regPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$regName  = "EnableTranscripting"
$regValue = 1

# STEP 2: Create the key path if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# STEP 3: Apply the value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord | Out-Null

# STEP 4: Output confirmation
Write-Host "STIG WN10-CC-000327 remediated. PowerShell Transcription has been enabled (EnableTranscripting = 1)."
