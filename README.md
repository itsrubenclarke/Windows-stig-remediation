# 💻 Windows 10 STIG Implementations

![Scripted in PowerShell](https://img.shields.io/badge/Scripted%20in-PowerShell-blue)
![Status](https://img.shields.io/badge/Status-Active-green)
![Framework](https://img.shields.io/badge/Framework-DISA%20STIGs-informational)

---

### 📖 Overview

This repository documents my practical approach to identifying and remediating Windows 10 STIG compliance issues using Tenable and PowerShell.

After running a credentialed compliance scan in Tenable, multiple misconfigurations were detected against the:
- [DISA Windows 10 STIG baseline](https://en.wikipedia.org/wiki/Security_Technical_Implementation_Guide).
  
Each failure represents a gap in system hardening, including areas like audit logging, privilege management, and access control.

To address these, I developed a series of targeted PowerShell scripts, each focused on remediating a specific STIG control. These scripts were tested individually, and their success was verified through subsequent Tenable scans.

This project demonstrates hands-on technical capability in:

- 🔍 Identifying misconfigurations using enterprise tools (Tenable.io)  
- 🛠 Writing and applying PowerShell remediations for specific findings  
- ✅ Confirming fixes through iterative scanning and validation  
- 📁 Documenting each implementation for repeatability and audit readiness  

This portfolio serves as both a technical showcase and a personal record of progress in implementing security controls aligned with DISA STIG requirements.

---

### 📄 Scan Reports

You can review the full Tenable scan results before and after remediation:
<table><tr><td><img src="https://github.com/user-attachments/assets/200d06be-da3e-4822-9a29-604d1bfa1cb3"  alt="Pre-Remediation Scan"></td></tr></table>


- 🔍 **Pre-Remediation Scan Report**: [Download PDF](https://github.com/user-attachments/files/20245052/Tenable-Scan-Before-Remediation.pdf)
- ✅ **Post-Remediation Scan Report**: [Download PDF](./reports/Tenable-Scan-After-Remediation.pdf)



---

### 📘 Table of Contents

| STIG ID | Title | Link |
|--------|-------|------|
| WN10-AC-000005 | Windows 10 account lockout duration must be configured to 15 minutes or greater. | [View Details](./WN10-AC-000005) |
| WN10-AC-000010 | The number of allowed bad logon attempts must be configured to 3 or fewer. | [View Details](./WN10-AC-000010) |
| WN10-AU-000045 | The system must be configured to audit Detailed File Share failures. | [View Details](./WN10-AU-000045) |
| WN10-AU-000054 | The system must be configured to audit Logon/Logoff failures. | [View Details](./WN10-AU-000054) |
| WN10-AU-000060 | The system must be configured to audit Logon/Logoff - Group Membership successes. | [View Details](./WN10-AU-000060) |
| WN10-AU-000110 | The system must be configured to audit Privilege Use - Sensitive Privilege Use failures. | [View Details](./WN10-AU-000110) |
| WN10-AU-000120 | The system must be configured to audit System - IPSec Driver failures. | [View Details](./WN10-AU-000120) |
| WN10-AU-000500 | The Application event log size must be configured to 32768 KB or greater. | [View Details](./WN10-AU-000500) |
| WN10-CC-000007 | Windows 10 must cover or disable the built-in or attached camera when not in use. | [View Details](./WN10-CC-000007) |
| WN10-CC-000010 | The display of slide shows on the lock screen must be disabled. | [View Details](./WN10-CC-000010) |

▶ More PowerShell remediations can be found [here](./WN10-CC-000010).











