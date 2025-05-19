# ⚙️ Prerequisites: For STIG Remediation Scripts

To ensure the PowerShell remediation scripts apply correctly and changes are verifiable across `AuditPol` or `gpedit.msc`, follow these steps **before running any scripts**.

---

## 1. Reset Audit Policies to Defaults (Recommended)

If you’ve previously tested or applied changes, starting from a clean baseline is good practice.

**Run the following in PowerShell:**
```powershell
# 1st clear all custom audit policy settings
auditpol /clear

# Then Reapply baseline policies
gpupdate /force
```
At this point, restart your computer.

## 2. Check Current Audit Policy Configuration

You can inspect the current audit policy settings at any time with the following:

```powershell
auditpol /get /category:*
```

## 3. Enable Subcategory, Based Audit Policy Enforcement
Many DISA STIG audit controls are defined at the subcategory level, which are ignored unless subcategory processing is explicitly enabled.

**Run the following in PowerShell:**
```powershell
auditpol /set /option:subcategoryaudit /value:enable
```

## 4. Apply the Prerequisite Audit Setting Once
Before applying any audit policy via script, you must enforce subcategory auditing using this one-time prerequisite.

**Run the following in PowerShell:**
```powershell
Start-Process -FilePath "auditpol.exe" `
  -ArgumentList "/set /option:subcategoryaudit /value:enable" `
  -NoNewWindow -Wait
```
