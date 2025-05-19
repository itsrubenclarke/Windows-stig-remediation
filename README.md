# 💻 Windows 10 STIG Compliance & Remediation

![Scripted in PowerShell](https://img.shields.io/badge/Scripted%20in-PowerShell-blue)
![Status](https://img.shields.io/badge/Status-Active-green)
![Framework](https://img.shields.io/badge/Framework-DISA%20STIGs-informational)

---

### 📖 Overview

This repository demonstrates a structured approach to identifying and addressing technical noncompliance when compared with the: 

- [DISA Windows 10 STIG baseline](https://en.wikipedia.org/wiki/Security_Technical_Implementation_Guide).
  
It combines enterprise compliance scanning with automated remediation using PowerShell.

> [!NOTE]
> **Before running any scripts, please review the [Prerequisites Guide.](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/prerequisites.md)** 

To ensure that audit policies are correctly configured and changes are verifiable.

After conducting a credentialed compliance scan in Tenable, several configuration issues were identified...

After conducting a credentialed compliance scan in Tenable, several configuration issues were identified that introduced risks to system integrity, auditability, and baseline hardening. These findings highlighted control failures across areas such as audit logging, access control, and privilege management.

To correct these issues, I developed a set of targeted PowerShell scripts, each aligned to a specific STIG control. The remediations were individually applied and verified through follow-up scans to ensure that each finding was resolved and the system returned to a compliant state. This process created an auditable trail of corrective action and supports ongoing assurance and compliance validation.

This project demonstrates hands-on technical capability in:

- 🔍 Identifying and analysing technical nonconformities using enterprise tools
- 🛠 Designing and applying corrective actions mapped to specific control objectives  
- ✅ Validating remediation outcomes through measurable evidence  
- 📁 Maintaining documentation that supports audit readiness and continual improvement

This portfolio serves as both a technical showcase and a practical demonstration of how an information security management system can be supported by automated control remediation and verification.

---

### 📄 Scan Reports

You can review the full Tenable scan results before and after remediation:
<table><tr><td><img src="https://github.com/user-attachments/assets/200d06be-da3e-4822-9a29-604d1bfa1cb3"  alt="Pre-Remediation Scan"></td></tr></table>


- 🔍 **Pre-Remediation Scan Report**: [Download PDF](https://github.com/user-attachments/files/20245052/Tenable-Scan-Before-Remediation.pdf)
- ✅ **Post-Remediation Scan Report**: [Download PDF](./reports/Tenable-Scan-After-Remediation.pdf)



---

### 📘 Table of Contents

| STIG ID | Title | Remediation |
|--------|-------|------|
| [WN10-AC-000005](https://stigaview.com/products/win10/v2r8/WN10-AC-000005/) | Windows 10 account lockout duration must be configured to 15 minutes or greater. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AC-000005.ps1) |
| [WN10-AC-000010](https://stigaview.com/products/win10/v2r8/WN10-AC-000010/) | The number of allowed bad logon attempts must be configured to 3 or fewer. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AC-000010.ps1) |
| [WN10-AU-000045](https://stigaview.com/products/win10/v2r8/WN10-AU-000045/) | The system must be configured to audit Detailed File Share failures. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AU-000045.ps1) |
| [WN10-AU-000054](https://stigaview.com/products/win10/v2r8/WN10-AU-000054/) | The system must be configured to audit Logon/Logoff failures. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AU-000054.ps1) |
| [WN10-AU-000060](https://stigaview.com/products/win10/v2r8/WN10-AU-000060/) | The system must be configured to audit Logon/Logoff - Group Membership successes. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AU-000060.ps1) |
| WN10-AU-000110 | The system must be configured to audit Privilege Use - Sensitive Privilege Use failures. | [View Details](./WN10-AU-000110) |
| WN10-AU-000120 | The system must be configured to audit System - IPSec Driver failures. | [View Details](./WN10-AU-000120) |
| [WN10-AU-000500](https://stigaview.com/products/win10/v2r8/WN10-AU-000500/) | The Application event log size must be configured to 32768 KB or greater. | [View Details](https://github.com/itsrubenclarke/Windows-stig-remediation/blob/main/Scripts/WN10-AU-000500.ps1) |
| WN10-CC-000007 | Windows 10 must cover or disable the built-in or attached camera when not in use. | [View Details](./WN10-CC-000007) |
| WN10-CC-000010 | The display of slide shows on the lock screen must be disabled. | [View Details](./WN10-CC-000010) |

▶ More PowerShell remediations can be found [here](./WN10-CC-000010).











